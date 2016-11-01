# Copyright (c) 2014, Ruslan Baratov & Luca Martini
# Copyright (c) 2014, Michele Caini
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
      nocodesign=False,
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
    self.is_ninja = (self.generator == 'Ninja')
    self.xp = xp
    self.is_xcode = (self.generator == 'Xcode')
    self.multiconfig = (self.is_xcode or self.is_msvc)
    self.nocodesign = nocodesign
    self.verify()

  def verify(self):
    if self.arch:
      assert(self.is_nmake or self.is_msvc or self.is_ninja)
      assert(self.arch == 'amd64' or self.arch == 'x86')

    if self.is_nmake or self.is_msvc:
      assert(self.vs_version)

    if self.ios_version or self.osx_version:
      assert(self.generator == 'Xcode')

    if self.xp:
      assert(self.vs_version)

toolchain_table = [
    Toolchain('default', ''),
    Toolchain('android-ndk-r10e-api-8-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-x86-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-gcc-49', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-64', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-64-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-mips', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-mips64', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-8-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-neon-clang-35-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-x86-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-19-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-armeabi', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-arm64-v8a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-arm64-v8a-gcc-49', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-arm64-v8a-gcc-49-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-arm64-v8a-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-x86-64', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-x86-64-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-mips', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-21-mips64', 'Unix Makefiles'),
    Toolchain('emscripten-cxx11', 'Unix Makefiles'),
    Toolchain('raspberrypi2-cxx11', 'Unix Makefiles')
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
          'ninja-vs-12-2013-win64',
          'Ninja',
          arch='amd64',
          vs_version='12'
      ),
      Toolchain(
          'ninja-vs-14-2015-win64',
          'Ninja',
          arch='amd64',
          vs_version='14'
      ),
      Toolchain(
          'vs-12-2013', 'Visual Studio 12 2013', arch='x86', vs_version='12'
      ),
      Toolchain(
          'vs-12-2013-mt', 'Visual Studio 12 2013', arch='x86', vs_version='12'
      ),
      Toolchain(
          'vs-10-2010', 'Visual Studio 10 2010', arch='x86', vs_version='10'
      ),
      Toolchain(
          'vs-11-2012', 'Visual Studio 11 2012', arch='x86', vs_version='11'
      ),
      Toolchain(
          'vs-14-2015', 'Visual Studio 14 2015', arch='x86', vs_version='14'
      ),
      Toolchain(
          'vs-14-2015-sdk-8-1', 'Visual Studio 14 2015', arch='x86', vs_version='14'
      ),
      Toolchain(
          'vs-9-2008', 'Visual Studio 9 2008', arch='x86', vs_version='9'
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
          'vs-11-2012-win64',
          'Visual Studio 11 2012 Win64',
          arch='amd64',
          vs_version='11'
      ),
      Toolchain(
          'vs-12-2013-win64',
          'Visual Studio 12 2013 Win64',
          arch='amd64',
          vs_version='12'
      ),
      Toolchain(
          'vs-14-2015-win64',
          'Visual Studio 14 2015 Win64',
          arch='amd64',
          vs_version='14'
      ),
      Toolchain(
          'vs-14-2015-win64-sdk-8-1',
          'Visual Studio 14 2015 Win64',
          arch='amd64',
          vs_version='14'
      ),
      Toolchain(
          'vs-11-2012-arm',
          'Visual Studio 11 2012 ARM',
          vs_version='11'
      ),
      Toolchain(
          'vs-12-2013-arm',
          'Visual Studio 12 2013 ARM',
          vs_version='12'
      ),
      Toolchain(
          'vs-14-2015-arm',
          'Visual Studio 14 2015 ARM',
          vs_version='14'
      ),
      Toolchain(
          'android-vc-ndk-r10e-api-19-arm-clang-3-6',
          'Visual Studio 14 2015 ARM',
          arch='',
          vs_version='14'
      ),
      Toolchain(
          'android-vc-ndk-r10e-api-21-arm-clang-3-6',
          'Visual Studio 14 2015 ARM',
          arch='',
          vs_version='14'
      ),
      Toolchain(
          'android-vc-ndk-r10e-api-19-x86-clang-3-6',
          'Visual Studio 14 2015',
          arch='',
          vs_version='14'
      ),
      Toolchain(
          'android-vc-ndk-r10e-api-19-arm-gcc-4-9',
          'Visual Studio 14 2015 ARM',
          arch='',
          vs_version='14'
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
      Toolchain('ios-10-1', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-arm64', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-armv7', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-wo-armv7s', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-0', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-arm64', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-armv7', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-wo-armv7s', 'Xcode', ios_version='10.0'),
      Toolchain('ios-9-3', 'Xcode', ios_version='9.3'),
      Toolchain('ios-9-3-arm64', 'Xcode', ios_version='9.3'),
      Toolchain('ios-9-3-armv7', 'Xcode', ios_version='9.3'),
      Toolchain('ios-9-3-wo-armv7s', 'Xcode', ios_version='9.3'),
      Toolchain('ios-9-2', 'Xcode', ios_version='9.2'),
      Toolchain('ios-9-2-arm64', 'Xcode', ios_version='9.2'),
      Toolchain('ios-9-2-armv7', 'Xcode', ios_version='9.2'),
      Toolchain('ios-9-2-hid', 'Xcode', ios_version='9.2'),
      Toolchain('ios-9-2-hid-sections', 'Xcode', ios_version='9.2'),
      Toolchain('ios-9-1-armv7', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-1-arm64', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-1-dep-7-0-armv7', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-1-hid', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-1-dep-8-0-hid', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-1', 'Xcode', ios_version='9.1'),
      Toolchain('ios-9-0', 'Xcode', ios_version='9.0'),
      Toolchain('ios-9-0-armv7', 'Xcode', ios_version='9.0'),
      Toolchain('ios-9-0-i386-armv7', 'Xcode', ios_version='9.0'),
      Toolchain('ios-9-0-wo-armv7s', 'Xcode', ios_version='9.0'),
      Toolchain('ios-9-0-dep-7-0-armv7', 'Xcode', ios_version='9.0'),
      Toolchain('ios-8-4', 'Xcode', ios_version='8.4'),
      Toolchain('ios-8-4-arm64', 'Xcode', ios_version='8.4'),
      Toolchain('ios-8-4-armv7', 'Xcode', ios_version='8.4'),
      Toolchain('ios-8-4-armv7s', 'Xcode', ios_version='8.4'),
      Toolchain('ios-8-4-hid', 'Xcode', ios_version='8.4'),
      Toolchain('ios-8-2', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-i386-arm64', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-arm64', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-arm64-hid', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-2-cxx98', 'Xcode', ios_version='8.2'),
      Toolchain('ios-8-1', 'Xcode', ios_version='8.1'),
      Toolchain('ios-8-0', 'Xcode', ios_version='8.0'),
      Toolchain('ios-7-1', 'Xcode', ios_version='7.1'),
      Toolchain('ios-7-0', 'Xcode', ios_version='7.0'),
      Toolchain('ios-nocodesign', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-arm64', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-armv7', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-hid-sections', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-wo-armv7s', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-8-4', 'Xcode', ios_version='8.4', nocodesign=True),
      Toolchain('ios-nocodesign-9-1', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-1-arm64', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-1-armv7', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-2', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-2-arm64', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-2-armv7', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-3', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-device', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-arm64', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-armv7', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-wo-armv7s', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-0', 'Xcode', ios_version='10.0', nocodesign=True),
      Toolchain('ios-nocodesign-10-0-arm64', 'Xcode', ios_version='10.0', nocodesign=True),
      Toolchain('ios-nocodesign-10-0-armv7', 'Xcode', ios_version='10.0', nocodesign=True),
      Toolchain('ios-nocodesign-10-0-wo-armv7s', 'Xcode', ios_version='10.0', nocodesign=True),
      Toolchain('ios-nocodesign-10-1', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-arm64', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-armv7', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-wo-armv7s', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('xcode', 'Xcode'),
      Toolchain('xcode-gcc', 'Xcode'),
      Toolchain('xcode-sections', 'Xcode'),
      Toolchain('osx-10-7', 'Xcode', osx_version='10.7'),
      Toolchain('osx-10-8', 'Xcode', osx_version='10.8'),
      Toolchain('osx-10-9', 'Xcode', osx_version='10.9'),
      Toolchain('osx-10-10', 'Xcode', osx_version='10.10'),
      Toolchain('osx-10-11', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-12', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-10-dep-10-7', 'Xcode', osx_version='10.10'),
      Toolchain('osx-10-10-dep-10-9-make', 'Unix Makefiles'),
      Toolchain('osx-10-11-sanitize-address', 'Xcode', osx_version='10.11'),
      Toolchain('linux-gcc-x64', 'Unix Makefiles'),
  ]

if os.name == 'posix':
  toolchain_table += [
      Toolchain('analyze', 'Unix Makefiles'),
      Toolchain('clang-lto', 'Unix Makefiles'),
      Toolchain('clang-libstdcxx', 'Unix Makefiles'),
      Toolchain('gcc', 'Unix Makefiles'),
      Toolchain('gcc-hid', 'Unix Makefiles'),
      Toolchain('gcc-hid-fpic', 'Unix Makefiles'),
      Toolchain('gcc-gold', 'Unix Makefiles'),
      Toolchain('gcc-pic', 'Unix Makefiles'),
      Toolchain('gcc-4-8', 'Unix Makefiles'),
      Toolchain('gcc-4-8-pic', 'Unix Makefiles'),
      Toolchain('gcc-cxx98', 'Unix Makefiles'),
      Toolchain('libcxx', 'Unix Makefiles'),
      Toolchain('libcxx-hid', 'Unix Makefiles'),
      Toolchain('libcxx-hid-fpic', 'Unix Makefiles'),
      Toolchain('libcxx-omp', 'Unix Makefiles'),
      Toolchain('sanitize-address', 'Unix Makefiles'),
  ]

def get_by_name(name):
  for x in toolchain_table:
    if name == x.name:
      return x
  sys.exit('Internal error: toolchain not found in toolchain table')
