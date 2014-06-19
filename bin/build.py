#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import argparse
import os
import re
import shutil
import subprocess
import sys

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
        'vs2013'
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
    '--fwd',
    nargs='*',
    help="Arguments to cmake without '-', like:\nDBOOST_ROOT=/some/path"
)

args = parser.parse_args()

for x in args.fwd:
  if not x.startswith('D'):
    sys.exit("Expected that forward argument starts with `D`: {}".format(x))

toolchain = ''
generator = ''

if args.config:
  tag = "{}-{}".format(args.toolchain, args.config)
else:
  tag = args.toolchain

if args.toolchain == 'libcxx':
  toolchain = 'libcxx'
elif args.toolchain == 'xcode':
  toolchain = 'xcode'
  generator = '-GXcode'
  tag = 'xcode'
elif args.toolchain == 'clang_libstdcxx':
  toolchain = 'clang_libstdcxx'
elif args.toolchain == 'default':
  toolchain = 'default'
elif args.toolchain == 'gcc48':
  toolchain = 'gcc48'
elif args.toolchain == 'gcc':
  toolchain = 'gcc'
elif args.toolchain == 'vs2013x64':
  generator = '-GVisual Studio 12 2013 Win64'
  tag = 'vs2013x64'
elif args.toolchain == 'vs2013':
  generator = '-GVisual Studio 12 2013'
  tag = 'vs2013'
else:
  assert(False)

cdir = os.getcwd()

def call(call_args):
  try:
    print('Execute command: [')
    for i in call_args:
      print('  `{}`'.format(i))
    print(']')
    if not args.verbose:
      subprocess.check_call(
          call_args,
          stdout=subprocess.DEVNULL,
          stderr=subprocess.DEVNULL,
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

toolchain_option = ''
if toolchain:
  toolchain_path = os.path.join(polly_root, "{}.cmake".format(toolchain))
  toolchain_option = "-DCMAKE_TOOLCHAIN_FILE={}".format(toolchain_path)

build_dir = os.path.join(cdir, '_builds', tag)
build_dir_option = "-B{}".format(build_dir)


shutil.rmtree(build_dir, ignore_errors=True)

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
  generate_command.append(
      '-DCMAKE_INSTALL_PREFIX={}'.format(
          os.path.join(cdir, '_install', args.toolchain)
      )
  )

for x in args.fwd:
  generate_command.append("-{}".format(x))

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

if (toolchain == 'xcode') and args.open:
  for file in os.listdir(build_dir):
    if file.endswith(".xcodeproj"):
      call(['open', os.path.join(build_dir, file)])

if args.test:
  os.chdir(build_dir)
  test_command = ['ctest']
  if args.config:
    test_command.append('--config')
    test_command.append(args.config)

  if args.verbose:
    test_command.append('-VV')

  call(test_command)
