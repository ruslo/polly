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
    '--type',
    required=True,
    help="CMake build type",
)

parser.add_argument('--test', action='store_true')
parser.add_argument('--open', action='store_true')
parser.add_argument('--verbose', action='store_true')

args = parser.parse_args()

toolchain = ''
generator = ''
tag = "{}-{}".format(args.toolchain, args.type)
if args.toolchain == 'libcxx':
  toolchain = 'libcxx'
elif args.toolchain == 'xcode':
  toolchain = 'xcode'
  generator = '-GXcode'
  tag = 'xcode'
elif args.toolchain == 'clang_libstdcxx':
  toolchain = 'clang_libstdcxx'
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

def call(args):
  try:
    print('Execute command: [')
    for i in args:
      print('  `{}`'.format(i))
    print(']')
    subprocess.check_call(
        args,
        stderr=subprocess.STDOUT,
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

build_type_for_generate_step = "-DCMAKE_BUILD_TYPE={}".format(args.type)

shutil.rmtree(build_dir, ignore_errors=True)

generate_command = [
    'cmake',
    '-H.',
    build_dir_option,
    build_type_for_generate_step
]

if generator:
  generate_command.append(generator)

if toolchain_option:
  generate_command.append(toolchain_option)

if args.verbose:
  generate_command.append('-DCMAKE_VERBOSE_MAKEFILE=ON')

build_command = [
    'cmake',
    '--build',
    build_dir,
    '--config',
    args.type
]

call(generate_command)
call(build_command)

if (toolchain == 'xcode') and args.open:
  for file in os.listdir(build_dir):
    if file.endswith(".xcodeproj"):
      call(['open', os.path.join(build_dir, file)])

if args.test:
  os.chdir(build_dir)
  test_command = ['ctest', '--config', args.type]

  if args.verbose:
    test_command.append('-VV')

  call(test_command)
