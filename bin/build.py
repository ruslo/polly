#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import argparse
import os
import shutil
import sys

import detail.call
import detail.cpack_generator
import detail.generate_command
import detail.get_nmake_environment
import detail.ios_dev_root
import detail.open_project
import detail.pack_command
import detail.test_command
import detail.toolchain_name
import detail.toolchain_table
import detail.verify_mingw_path

toolchain_table = detail.toolchain_table.toolchain_table

assert(sys.version_info.major == 3)
assert(sys.version_info.minor >= 2) # Current cygwin version is 3.2.3

description="""
Script for building. Available toolchains:\n
"""

for x in toolchain_table:
  description += '  ' + x.name + '\n'

parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=description
)

parser.add_argument(
    '--toolchain',
    choices=[x.name for x in toolchain_table],
    help="CMake generator/toolchain",
)

parser.add_argument(
    '--config',
    help="CMake build type (Release, Debug, ...)",
)

parser.add_argument(
    '--home',
    help="Project home directory (directory with CMakeLists.txt)"
)

parser.add_argument('--test', action='store_true', help="Run ctest after build")
parser.add_argument('--pack', action='store_true', help="Run cpack after build")
parser.add_argument(
    '--nobuild', action='store_true', help="Do not build (only generate)"
)
parser.add_argument(
    '--open', action='store_true', help="Open generated project (for IDE)"
)
parser.add_argument('--verbose', action='store_true', help="Verbose output")
parser.add_argument(
    '--install', action='store_true', help="Run install (local directory)"
)
parser.add_argument(
    '--clear',
    action='store_true',
    help="Remove build and install dirs before build"
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

polly_toolchain = detail.toolchain_name.get(args.toolchain)
toolchain_entry = detail.toolchain_table.get_by_name(polly_toolchain)
cpack_generator = detail.cpack_generator.get(args.pack)

polly_root = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..')
polly_root = os.path.realpath(polly_root)

"""Build directory tag"""
if args.config and not toolchain_entry.multiconfig:
  build_tag = "{}-{}".format(polly_toolchain, args.config)
else:
  build_tag = polly_toolchain

"""Tune environment"""
if toolchain_entry.name == 'mingw':
  mingw_path = os.getenv("MINGW_PATH")
  detail.verify_mingw_path.verify(mingw_path)
  os.environ['PATH'] = "{};{}".format(mingw_path, os.getenv('PATH'))

if toolchain_entry.is_nmake:
  os.environ = detail.get_nmake_environment.get(
      toolchain_entry.arch, toolchain_entry.vs_version
  )

if toolchain_entry.ios_version:
  ios_dev_root = detail.ios_dev_root.get(toolchain_entry.ios_version)
  if ios_dev_root:
    if args.verbose:
      print("Set environment DEVELOPER_DIR to {}".format(ios_dev_root))
    os.environ['DEVELOPER_DIR'] = ios_dev_root

if toolchain_entry.name == 'ios-nocodesign':
  xcconfig = os.path.join(polly_root, 'scripts', 'NoCodeSign.xcconfig')
  if args.verbose:
    print("Set environment XCODE_XCCONFIG_FILE to {}".format(xcconfig))
  os.environ['XCODE_XCCONFIG_FILE'] = xcconfig

cdir = os.getcwd()

if args.verbose:
  if os.name == 'nt':
    # Windows
    detail.call.call(['where', 'cmake'], args.verbose)
  else:
    detail.call.call(['which', 'cmake'], args.verbose)
  detail.call.call(['cmake', '--version'], args.verbose)

toolchain_path = os.path.join(polly_root, "{}.cmake".format(polly_toolchain))
if not os.path.exists(toolchain_path):
  sys.exit("Toolchain file not found: {}".format(toolchain_path))
toolchain_option = "-DCMAKE_TOOLCHAIN_FILE={}".format(toolchain_path)

build_dir = os.path.join(cdir, '_builds', build_tag)
if args.verbose:
  print("Build dir: {}".format(build_dir))
build_dir_option = "-B{}".format(build_dir)

install_dir = os.path.join(cdir, '_install', polly_toolchain)
if args.install:
  install_dir_option = "-DCMAKE_INSTALL_PREFIX={}".format(install_dir)

if args.clear:
  print("Remove build directory: {}".format(build_dir))
  shutil.rmtree(build_dir, ignore_errors=True)
  print("Remove install directory: {}".format(install_dir))
  shutil.rmtree(install_dir, ignore_errors=True)

home = '.'
if args.home:
  home = args.home

generate_command = [
    'cmake',
    '-H{}'.format(home),
    build_dir_option
]

if args.config and not toolchain_entry.multiconfig:
  generate_command.append("-DCMAKE_BUILD_TYPE={}".format(args.config))

if toolchain_entry.generator:
  generate_command.append('-G{}'.format(toolchain_entry.generator))

if toolchain_option:
  generate_command.append(toolchain_option)

if args.verbose:
  generate_command.append('-DCMAKE_VERBOSE_MAKEFILE=ON')
  generate_command.append('-DPOLLY_STATUS_DEBUG=ON')
  generate_command.append('-DHUNTER_STATUS_DEBUG=ON')

if args.install:
  generate_command.append(install_dir_option)

if cpack_generator:
  generate_command.append('-DCPACK_GENERATOR={}'.format(cpack_generator))

if args.fwd != None:
  for x in args.fwd:
    generate_command.append("-D{}".format(x))

detail.generate_command.run(generate_command, build_dir, args.verbose)

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
  detail.call.call(build_command, args.verbose)

if not args.nobuild:
  os.chdir(build_dir)
  if args.test:
    detail.test_command.run(build_dir, args.config, args.verbose)
  if args.pack:
    detail.pack_command.run(args.config, args.verbose, cpack_generator)

if args.open:
  detail.open_project.open(toolchain_entry, build_dir, args.verbose)
