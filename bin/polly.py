#!/usr/bin/env python3

# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

import argparse
import os
import platform
import shutil
import sys

import detail.call
import detail.cpack_generator
import detail.create_archive
import detail.create_framework
import detail.generate_command
import detail.get_nmake_environment
import detail.ios_dev_root
import detail.logging
import detail.open_project
import detail.osx_dev_root
import detail.pack_command
import detail.rmtree
import detail.target
import detail.test_command
import detail.timer
import detail.toolchain_name
import detail.toolchain_table
import detail.verify_mingw_path
import detail.verify_msys_path

toolchain_table = detail.toolchain_table.toolchain_table

assert(sys.version_info.major == 3)
assert(sys.version_info.minor >= 2) # Current cygwin version is 3.2.3

print(
    'Python version: {}.{}'.format(
        sys.version_info.major, sys.version_info.minor
     )
)

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
  '--keep-going',
  action='store_true',
  help="Continue  as  much as  possible after an error. see make -k"
)

parser.add_argument(
    '--config-all',
    help="CMake build type for project and hunter packages: --config <type> --fwd HUNTER_CONFIGURATION_TYPES=<type>",
)

parser.add_argument(
    '--home',
    help="Project home directory (directory with CMakeLists.txt)"
)

parser.add_argument(
    '--output',
    help="Project build directory (i.e., cmake -B)"
)

parser.add_argument(
    '--cache',
    help="CMake -C <initial-cache> = Pre-load a script to populate the cache."
)

parser.add_argument('--test', action='store_true', help="Run ctest after build")
parser.add_argument('--test-xml', help="Save ctest output to xml")

parser.add_argument(
    '--pack',
    choices=detail.cpack_generator.available_generators,
    nargs='?',
    const=detail.cpack_generator.default(),
    help="Run cpack after build"
)
parser.add_argument(
    '--archive',
    help="Create an archive of locally installed files"
)
parser.add_argument(
    '--nobuild', action='store_true', help="Do not build (only generate)"
)
parser.add_argument(
    '--open', action='store_true', help="Open generated project (for IDE)"
)

verbosity_group=parser.add_mutually_exclusive_group()
verbosity_group.add_argument(
    '--verbosity-level', dest='verbosity', help="Verbosity level",
    choices=['silent', 'normal', 'full'], default='normal'
)
verbosity_group.add_argument('--verbose', action='store_true', help="Full verbose output")

parser.add_argument(
    '--install', action='store_true', help="Run install (local directory)"
)
parser.add_argument(
    '--ios-multiarch',
    action='store_true',
    help="Build multi-architecture binary (effectively add CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO)"
)
parser.add_argument(
    '--ios-combined',
    action='store_true',
    help="Combine iOS simulator and device libraries on install (effectively add CMAKE_IOS_INSTALL_COMBINED=YES)"
)
parser.add_argument(
    '--framework', action='store_true', help="Create framework"
)
parser.add_argument(
    '--framework-device',
    action='store_true',
    help="Create framework for device (exclude simulator architectures)"
)
parser.add_argument(
    '--framework-lib',
    default='*',
    help="Regular expression for the source library used for --framework"
)
parser.add_argument(
    '--strip', action='store_true', help="Run strip/install cmake targets"
)
parser.add_argument(
    '--identity',
    help="Specify code signing identity for --framework"
)
parser.add_argument(
    '--plist',
    help="User specified Info.plist file for --framework"
)
parser.add_argument(
    '--clear',
    action='store_true',
    help="Remove build and install dirs before build"
)
parser.add_argument(
    '--reconfig',
    action='store_true',
    help="Run configure even if CMakeCache.txt exists. Used to add new args."
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

parser.add_argument(
    '--jobs',
    type=int,
    help="Number of concurrent build operations"
)

parser.add_argument(
    '--target',
    help="Target to build for the 'cmake --build' command"
)

def PositiveInt(string):
  value = int(string)
  if value > 0:
    return value
  m = 'Should be greater that zero: {}'.format(string)
  raise argparse.ArgumentTypeError(m)

parser.add_argument(
    '--discard',
    type=PositiveInt,
    help='Option to reduce output. Discard every N lines of execution messages'
        ' (note that full log is still available in log.txt)'
)

parser.add_argument(
    '--tail',
    type=PositiveInt,
    help='Print last N lines if build failed'
)

parser.add_argument(
    '--timeout',
    type=PositiveInt,
    help='Timeout for CTest'
)

parser.add_argument(
    '--cmake',
    help="CMake binary (cmake or cmake3)"
)

parser.add_argument(
    '--cpack',
    help="CPack binary (cpack or cpack3)"
)

parser.add_argument(
    '--ctest',
    help="CTest binary (ctest or ctest3)"
)

args = parser.parse_args()

polly_toolchain = detail.toolchain_name.get(args.toolchain)
toolchain_entry = detail.toolchain_table.get_by_name(polly_toolchain)
cpack_generator = args.pack

polly_root = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..')
polly_root = os.path.realpath(polly_root)

if args.config and args.config_all:
  sys.exit('Must specify --config or --config-all but not both')

if args.config_all:
  args.config = args.config_all

"""Build directory tag"""
if args.config and not toolchain_entry.multiconfig:
  build_tag = "{}-{}".format(polly_toolchain, args.config)
else:
  build_tag = polly_toolchain

"""Tune environment"""
if toolchain_entry.name.startswith('mingw'):  
  mingw_path = os.getenv("MINGW_PATH")
  detail.verify_mingw_path.verify(mingw_path)
  os.environ['PATH'] = "{};{}".format(mingw_path, os.getenv('PATH'))

if toolchain_entry.name.startswith('msys'): 
  msys_path = os.getenv("MSYS_PATH")
  detail.verify_msys_path.verify(msys_path)
  os.environ['PATH'] = "{};{}".format(msys_path, os.getenv('PATH'))

vs_ninja = toolchain_entry.is_ninja and toolchain_entry.vs_version
if toolchain_entry.is_nmake or vs_ninja:
  os.environ = detail.get_nmake_environment.get(
      toolchain_entry.arch, toolchain_entry.vs_version
  )

if toolchain_entry.ios_version:
  ios_dev_root = detail.ios_dev_root.get(toolchain_entry.ios_version)
  if ios_dev_root:
    print("Set environment DEVELOPER_DIR to {}".format(ios_dev_root))
    os.environ['DEVELOPER_DIR'] = ios_dev_root

if toolchain_entry.nocodesign:
  xcconfig = os.path.join(polly_root, 'scripts', 'NoCodeSign.xcconfig')
  print("Set environment XCODE_XCCONFIG_FILE to {}".format(xcconfig))
  os.environ['XCODE_XCCONFIG_FILE'] = xcconfig

if toolchain_entry.osx_version:
  osx_dev_root = detail.osx_dev_root.get(toolchain_entry.osx_version)
  if osx_dev_root:
    print("Set environment DEVELOPER_DIR to {}".format(osx_dev_root))
    os.environ['DEVELOPER_DIR'] = osx_dev_root

toolchain_path = os.path.join(polly_root, "{}.cmake".format(polly_toolchain))
if not os.path.exists(toolchain_path):
  sys.exit("Toolchain file not found: {}".format(toolchain_path))
toolchain_option = "-DCMAKE_TOOLCHAIN_FILE={}".format(toolchain_path)

if args.output:
  if not os.path.isdir(args.output):
    sys.exit("Specified build directory does not exist: {}".format(args.output))
  if not os.access(args.output, os.W_OK):
    sys.exit("Specified build directory is not writeable: {}".format(args.output))
  cdir = args.output
else:
  cdir = os.getcwd()

build_dir = os.path.join(cdir, '_builds', build_tag)
print("Build dir: {}".format(build_dir))
build_dir_option = "-B{}".format(build_dir)

install_dir = os.path.join(cdir, '_install', polly_toolchain)
local_install = args.install or args.strip or args.framework or args.framework_device or args.archive

if args.install and args.strip:
  sys.exit('Both --install and --strip specified')

if args.strip:
  install_target_name = 'install/strip'
elif local_install:
  install_target_name = 'install'
else:
  install_target_name = '' # not used

target = detail.target.Target()

target.add(condition=local_install, name=install_target_name)
target.add(condition=args.target, name=args.target)

# After 'target.add'
if args.strip and not toolchain_entry.is_make:
  sys.exit('CMake install/strip targets are only supported for the Unix Makefile generator')

if local_install:
  install_dir_option = "-DCMAKE_INSTALL_PREFIX={}".format(install_dir)

if (args.framework or args.framework_device) and platform.system() != 'Darwin':
  sys.exit('Framework creation only for Mac OS X')
framework_dir = os.path.join(cdir, '_framework', polly_toolchain)
archives_dir = os.path.join(cdir, '_archives')

if args.clear:
  detail.rmtree.rmtree(build_dir)
  detail.rmtree.rmtree(install_dir)
  detail.rmtree.rmtree(framework_dir)

# --verbose flag triggers full verbosity level
if args.verbose:
    args.verbosity='full'

polly_temp_dir = os.path.join(build_dir, '_3rdParty', 'polly')
if not os.path.exists(polly_temp_dir):
  os.makedirs(polly_temp_dir)
logging = detail.logging.Logging(
    cdir, args.verbosity, args.discard, args.tail, polly_toolchain
)

if args.cmake:
  cmake_bin = args.cmake
else:
  cmake_bin = 'cmake'

if os.path.isabs(cmake_bin):
  if not os.path.exists(cmake_bin):
    sys.exit("CMake binary not found: {}".format(cmake_bin))
else:
  if os.name == 'nt':
    # Windows
    detail.call.call(['where', cmake_bin], logging)
  else:
    detail.call.call(['which', cmake_bin], logging)
detail.call.call([cmake_bin, '--version'], logging)

home = '.'
if args.home:
  home = args.home

generate_command = [
    cmake_bin,
    '-H{}'.format(home),
    build_dir_option
]

if args.cache:
  if not os.path.isfile(args.cache):
    sys.exit("Specified cache file does not exist: {}".format(args.cache))
  if not os.access(args.cache, os.R_OK):
    sys.exit("Specified cache file is not readable: {}".format(args.cache))
  generate_command.append("-C{}".format(args.cache))

if (args.config and not toolchain_entry.multiconfig) or args.config_all:
  generate_command.append("-DCMAKE_BUILD_TYPE={}".format(args.config))

if toolchain_entry.generator:
  generate_command.append('-G{}'.format(toolchain_entry.generator))

if toolchain_entry.xp:
  toolset = 'v{}0_xp'.format(toolchain_entry.vs_version)
  generate_command.append('-T{}'.format(toolset))

if toolchain_option:
  generate_command.append(toolchain_option)

if args.verbosity == 'full':
    generate_command.append('-DCMAKE_VERBOSE_MAKEFILE=ON')
    generate_command.append('-DPOLLY_STATUS_DEBUG=ON')
    generate_command.append('-DHUNTER_STATUS_DEBUG=ON')

if args.ios_multiarch:
    generate_command.append('-DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO')

if args.ios_combined:
    generate_command.append('-DCMAKE_IOS_INSTALL_COMBINED=YES')

if local_install:
  generate_command.append(install_dir_option)

if cpack_generator:
  generate_command.append('-DCPACK_GENERATOR={}'.format(cpack_generator))

if args.fwd != None:
  for x in args.fwd:
    generate_command.append("-D{}".format(x))

if args.config_all:
  generate_command.append("-DHUNTER_CONFIGURATION_TYPES={}".format(args.config_all))
    
timer = detail.timer.Timer()

timer.start('Generate')
detail.generate_command.run(
    generate_command, build_dir, polly_temp_dir, args.reconfig, logging
)
timer.stop()

build_command = [
    cmake_bin,
    '--build',
    build_dir
]

if args.config:
  build_command.append('--config')
  build_command.append(args.config)

build_command += target.args()

# NOTE: This must be the last `build_command` modification!
build_command.append('--')

if args.iossim:
  build_command.append('-arch')
  build_command.append('i386')
  build_command.append('-sdk')
  build_command.append('iphonesimulator')

if args.jobs:
  if toolchain_entry.is_xcode:
    build_command.append('-jobs')
    build_command.append('{}'.format(args.jobs))
  elif toolchain_entry.is_make and not toolchain_entry.is_nmake:
    build_command.append('-j')
    build_command.append('{}'.format(args.jobs))
  elif toolchain_entry.is_msvc and (int(toolchain_entry.vs_version) >= 12):
    build_command.append('/maxcpucount:{}'.format(args.jobs))

if args.keep_going:
  if toolchain_entry.is_make:
    build_command.append('-k') ## keep going
    
if not args.nobuild:
  timer.start('Build')
  detail.call.call(build_command, logging, sleep=1)
  timer.stop()

  if args.archive:
    timer.start('Archive creation')
    detail.create_archive.run(
        install_dir,
        archives_dir,
        args.archive,
        toolchain_entry.name,
        args.config
    )
    timer.stop()

  if args.framework or args.framework_device:
    timer.start('Framework creation')
    detail.create_framework.run(
        install_dir,
        framework_dir,
        toolchain_entry.ios_version,
        polly_root,
        args.framework_device,
        logging,
        args.plist,
        args.identity,
        args.framework_lib
    )
    timer.stop()

if not args.nobuild:
  os.chdir(build_dir)
  if args.test or args.test_xml:
    timer.start('Test')

    if args.ctest:
      ctest_bin = args.ctest
    else:
      ctest_bin = 'ctest'

    if os.path.isabs(ctest_bin):
      if not os.path.exists(ctest_bin):
        sys.exit("Ctest binary not found: {}".format(ctest_bin))

    detail.test_command.run(build_dir, args.config, logging, args.test_xml, args.verbosity == 'full', args.timeout, ctest_bin)
    timer.stop()
  if args.pack:
    timer.start('Pack')

    if args.cpack:
      cpack_bin = args.cpack
    else:
      cpack_bin = 'cpack'

    if os.path.isabs(cpack_bin):
      if not os.path.exists(cpack_bin):
        sys.exit("CPack binary not found: {}".format(cpack_bin))

    detail.pack_command.run(args.config, logging, cpack_generator, cpack_bin, cmake_bin)
    timer.stop()

if args.open:
  detail.open_project.open(toolchain_entry, build_dir, logging)

print('-')
print('Log saved: {}'.format(logging.log_path))
print('-')
timer.result()
print('-')
print('SUCCESS')
