#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import argparse
import os
import re
import shutil
import subprocess
import sys
import detail.util

assert(sys.version_info.major == 3)
assert(sys.version_info.minor >= 2) # Current cygwin version is 3.2.3

parser = argparse.ArgumentParser(description="Script for building")
parser.add_argument(
    '--toolchain',
    choices=[
        'default',
        'libcxx',
        'xcode',
        'clang_libstdcxx',
        'gcc48',
        'gcc',
        'vs2013x64',
        'vs2013',
        'analyze',
        'sanitize_address',
        'sanitize_leak',
        'sanitize_memory',
        'sanitize_thread',
        'cygwin',
        'mingw',
        'ios',
        'ios-nocodesign',
        'nmake-vs2013-x64'
    ],
    help="CMake generator/toolchain",
)

parser.add_argument(
    '--config',
    help="CMake build type (Release, Debug, ...)",
)

parser.add_argument('--test', action='store_true', help="Run ctest after build")
parser.add_argument(
    '--nobuild', action='store_true', help="Do not build (only generate)"
)
parser.add_argument(
    '--open', action='store_true', help="Open generated project (for IDE)"
)
parser.add_argument('--verbose', action='store_true', help="Verbose output")
parser.add_argument('--install', action='store_true', help="Run install")
parser.add_argument(
    '--clear', action='store_true', help="Remove build and install dirs"
)
parser.add_argument(
    '--fwd',
    nargs='*',
    help="Arguments to cmake without '-D', like:\nBOOST_ROOT=/some/path"
)
parser.add_argument(
    '--iossim',
    action='store_true',
    help="Build for ios i386 simulator"
)

args = parser.parse_args()

generator = ''

"""Toolchain name"""
polly_toolchain = ''
if args.toolchain:
  polly_toolchain = args.toolchain
else:
  polly_toolchain = 'default'

if args.toolchain == 'vs2013x64':
  polly_toolchain = 'vs-12-2013-win64'
elif args.toolchain == 'vs2013':
  polly_toolchain = 'vs-12-2013'

"""Build directory tag"""
multi_config_dir = False
if args.toolchain == 'vs2013x64':
  multi_config_dir = True
elif args.toolchain == 'vs2013':
  multi_config_dir = True
elif args.toolchain == 'xcode':
  multi_config_dir = True

if args.config and not multi_config_dir:
  build_tag = "{}-{}".format(polly_toolchain, args.config)
else:
  build_tag = polly_toolchain

"""Generator"""
if args.toolchain == 'vs2013x64':
  generator = '-GVisual Studio 12 2013 Win64'
elif args.toolchain == 'vs2013':
  generator = '-GVisual Studio 12 2013'
elif args.toolchain == 'xcode':
  generator = '-GXcode'
elif args.toolchain == 'ios':
  generator = '-GXcode'
elif args.toolchain == 'ios-nocodesign':
  generator = '-GXcode'
elif args.toolchain == 'mingw':
  generator = '-GMinGW Makefiles'
elif args.toolchain == 'nmake-vs2013-x64':
  generator = '-GNMake Makefiles'

"""Tune environment"""
if args.toolchain == 'mingw':
  mingw_path = os.getenv("MINGW_PATH")
  if not mingw_path:
    sys.exit(
        "Please set environment variable MINGW_PATH "
        "to directory with mingw32-make.exe"
    )
  if not os.path.isdir(mingw_path):
    sys.exit("MINGW_PATH({}) is not a directory".format(mingw_path))

  mingw_make = os.path.join(mingw_path, 'mingw32-make.exe')
  if not os.path.isfile(mingw_make):
    sys.exit(
        "File mingw32-make.exe not found in "
        "directory `{}` (MINGW_PATH environment variable)".format(mingw_path)
    )
  os.environ['PATH'] = "{};{}".format(mingw_path, os.getenv('PATH'))

if args.toolchain == 'nmake-vs2013-x64':
  vs_path = os.getenv('VS120COMNTOOLS')
  if not vs_path:
    sys.exit(
        'Environment variable VS120COMNTOOLS is empty, '
        'looks like Visual Studio 2013 is not installed'
    )
  vcvarsall_dir = os.path.join(vs_path, '..', '..', 'VC')
  if not os.path.isdir(vcvarsall_dir):
    sys.exit(
        'Directory `{}` not exists '
        '(VS120COMNTOOLS environment variable)'.format(vcvarsall_dir)
    )
  vcvarsall_path = os.path.join(vcvarsall_dir, 'vcvarsall.bat')
  if not os.path.isfile(vcvarsall_path):
    sys.exit(
        'File vcvarsall.bat not found in directory '
        '`{}` (VS120COMNTOOLS_ environment variable)'.format(vcvarsall_dir)
    )
  new_env = detail.util.get_environment_from_batch_command([vcvarsall_path, 'amd64'])
  os.environ = new_env

cdir = os.getcwd()

# workaround for version less that 3.3
DEVNULL = open(os.devnull, 'w')

def call(call_args):
  try:
    print('Execute command: [')
    for i in call_args:
      print('  `{}`'.format(i))
    print(']')
    if not args.verbose:
      subprocess.check_call(
          call_args,
          stdout=DEVNULL,
          stderr=DEVNULL,
          universal_newlines=True,
          env=os.environ
      )
    else:
      subprocess.check_call(
          call_args,
          universal_newlines=True,
          env=os.environ
      )
  except subprocess.CalledProcessError as error:
    print(error)
    print(error.output)
    sys.exit(1)
  except FileNotFoundError as error:
    print(error)
    sys.exit(1)

call(['cmake', '--version'])

polly_root = os.getenv("POLLY_ROOT")
if not polly_root:
  sys.exit("Environment variable `POLLY_ROOT` is empty")

toolchain_path = os.path.join(polly_root, "{}.cmake".format(polly_toolchain))
toolchain_option = "-DCMAKE_TOOLCHAIN_FILE={}".format(toolchain_path)

build_dir = os.path.join(cdir, '_builds', build_tag)
build_dir_option = "-B{}".format(build_dir)

install_dir = os.path.join(cdir, '_install', polly_toolchain)
if args.install:
  install_dir_option = "-DCMAKE_INSTALL_PREFIX={}".format(install_dir)

if args.clear:
  print("Remove build directory: {}".format(build_dir))
  shutil.rmtree(build_dir, ignore_errors=True)
  print("Remove install directory: {}".format(install_dir))
  shutil.rmtree(install_dir, ignore_errors=True)
  sys.exit()

generate_command = [
    'cmake',
    '-H.',
    build_dir_option
]

if args.config:
  generate_command.append("-DCMAKE_BUILD_TYPE={}".format(args.config))

if generator:
  generate_command.append(generator)

if toolchain_option:
  generate_command.append(toolchain_option)

if args.verbose:
  generate_command.append('-DCMAKE_VERBOSE_MAKEFILE=ON')

if args.install:
  generate_command.append(install_dir_option)

if args.fwd != None:
  for x in args.fwd:
    generate_command.append("-D{}".format(x))

call(generate_command)

build_command = [
    'cmake',
    '--build',
    build_dir
]

if args.config:
  build_command.append('--config')
  build_command.append(args.config)

if args.install:
  build_command.append('--target')
  build_command.append('install')

# NOTE: This must be the last `build_command` modification!
if args.iossim:
  build_command.append('--')
  build_command.append('-arch')
  build_command.append('i386')
  build_command.append('-sdk')
  build_command.append('iphonesimulator')

if not args.nobuild:
  call(build_command)

def find_project(directory, extension):
  for file in os.listdir(directory):
    if file.endswith(extension):
      project_path = os.path.join(directory, file)
      if args.verbose:
        print("Open project: {}".format(project_path))
      return project_path
  sys.exit(
      "Project with extension `{}` not found in `{}`".format(
          extension,
          directory
      )
  )

if args.open:
  if (generator == '-GXcode'):
    call(['open', find_project(build_dir, ".xcodeproj")])
  if generator.startswith('-GVisual Studio'):
    os.startfile(find_project(build_dir, ".sln"))

if args.test and not args.nobuild:
  os.chdir(build_dir)
  test_command = ['ctest']
  if args.config:
    test_command.append('--config')
    test_command.append(args.config)

  if args.verbose:
    test_command.append('-VV')

  call(test_command)
