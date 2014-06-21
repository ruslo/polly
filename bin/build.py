#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import argparse
import os
import re
import shutil
import subprocess
import sys

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
          universal_newlines=True
      )
    else:
      subprocess.check_call(
          call_args,
          universal_newlines=True
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

if not args.nobuild:
  call(build_command)

if args.open:
  if (args.toolchain == 'xcode'):
    for file in os.listdir(build_dir):
      if file.endswith(".xcodeproj"):
        call(['open', os.path.join(build_dir, file)])
  if (args.toolchain == 'vs2013x64') or (args.toolchain == 'vs2013'):
    for file in os.listdir(build_dir):
      if file.endswith(".sln"):
        os.startfile(os.path.join(build_dir, file))

if args.test:
  os.chdir(build_dir)
  test_command = ['ctest']
  if args.config:
    test_command.append('--config')
    test_command.append(args.config)

  if args.verbose:
    test_command.append('-VV')

  call(test_command)
