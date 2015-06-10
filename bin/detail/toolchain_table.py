# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import platform

class Toolchain:
  def __init__(
      self,
      name,
      generator,
      arch='',
      vs_version='',
      ios_version='',
      osx_version='',
      xp=False,
  ):
    self.name = name
    self.generator = generator
    self.arch = arch
    self.vs_version = vs_version
    self.ios_version = ios_version
    self.osx_version = osx_version
    self.is_nmake = (self.generator == 'NMake Makefiles')
    self.is_msvc = self.generator.startswith('Visual Studio')
    self.is_make = self.generator.endswith('Makefiles')
    self.xp = xp
    self.is_xcode = (self.generator == 'Xcode')
    self.multiconfig = (self.is_xcode or self.is_msvc)
    self.verify()

  def verify(self):
    if self.arch:
      assert(self.is_nmake or self.is_msvc)
      assert(self.arch == 'amd64' or self.arch == 'x86')

    if self.is_nmake or self.is_msvc:
      assert(self.vs_version)

    if self.ios_version or self.osx_version:
      assert(self.generator == 'Xcode')

    if self.xp:
      assert(self.vs_version)

toolchain_table = [
    Toolchain('default', ''),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-8-armeabi-v7a', 'Unix Makefiles'),
]

if os.name == 'nt':
  toolchain_table += [
      Toolchain('mingw', 'MinGW Makefiles'),
      Toolchain('msys', 'MSYS Makefiles'),
      Toolchain(
          'nmake-vs-12-2013',
          'NMake Makefiles',
          arch='x86',
          vs_version='12'
      ),
      Toolchain(
          'nmake-vs-12-2013-win64',
          'NMake Makefiles',
          arch='amd64',
          vs_version='12'
      ),
      Toolchain(
          'vs-12-2013', 'Visual Studio 12 2013', arch='x86', vs_version='12'
      ),
      Toolchain(
          'vs-8-2005', 'Visual Studio 8 2005', arch='x86', vs_version='8'
      ),
      Toolchain(
          'vs-12-2013-xp',
          'Visual Studio 12 2013',
          arch='x86',
          vs_version='12',
          xp=True
      ),
      Toolchain(
          'vs-12-2013-win64',
          'Visual Studio 12 2013 Win64',
          arch='amd64',
          vs_version='12'
      ),
  ]

if platform.system().startswith('CYGWIN'):
  toolchain_table += [
      Toolchain('cygwin', 'Unix Makefiles'),
  ]

if platform.system() == 'Linux':
  toolchain_table += [
      Toolchain('sanitize-leak', 'Unix Makefiles'),
      Toolchain('sanitize-memory', 'Unix Makefiles'),
      Toolchain('sanitize-thread', 'Unix Makefiles'),
  ]

if platform.system() == 'Darwin':
  toolchain_table += [
      Toolchain('ios-8-2', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-i386-arm64', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-arm64', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-cxx98', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-1', 'Xcode', ios_version='8.1'),
      Toolchain('ios-8-0', 'Xcode', ios_version='8.0'),
      Toolchain('ios-7-1', 'Xcode', ios_version='7.1'),
      Toolchain('ios-7-0', 'Xcode', ios_version='7.0'),
      Toolchain('ios-nocodesign', 'Xcode', ios_version='7.1'),
      Toolchain('xcode', 'Xcode'),
      Toolchain('osx-10-7', 'Xcode', osx_version='10.7'),
      Toolchain('osx-10-8', 'Xcode', osx_version='10.8'),
      Toolchain('osx-10-9', 'Xcode', osx_version='10.9'),
      Toolchain('osx-10-10', 'Xcode', osx_version='10.10'),
      Toolchain('osx-10-10-dep-10-7', 'Xcode', osx_version='10.10'),
  ]

if os.name == 'posix':
  toolchain_table += [
      Toolchain('analyze', 'Unix Makefiles'),
      Toolchain('clang-lto', 'Unix Makefiles'),
      Toolchain('clang-libstdcxx', 'Unix Makefiles'),
      Toolchain('gcc', 'Unix Makefiles'),
      Toolchain('gcc-pic', 'Unix Makefiles'),
      Toolchain('gcc-4-8', 'Unix Makefiles'),
      Toolchain('libcxx', 'Unix Makefiles'),
      Toolchain('libcxx-omp', 'Unix Makefiles'),
      Toolchain('sanitize-address', 'Unix Makefiles'),
  ]

def get_by_name(name):
  for x in toolchain_table:
    if name == x.name:
      return x
  sys.exit('Internal error: toolchain not found in toolchain table')
