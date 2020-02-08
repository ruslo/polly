# Copyright (c) 2014-2019, Ruslan Baratov & Luca Martini
# Copyright (c) 2014-2019, Michele Caini
# Copyright (c) 2017-2019, Robert Nitsch
# Copyright (c) 2018-2019, David Hirvonen
# Copyright (c) 2018-2019, Richard Hodges
# All rights reserved.

import os
import platform

class Toolchain:
  def __init__(
      self,
      name,
      generator,
      toolset='',
      arch='',
      vs_version='',
      ios_version='',
      osx_version='',
      xp=False,
      nocodesign=False,
  ):
    self.name = name
    self.generator = generator
    self.toolset = toolset
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
    Toolchain('cxx11', ''),
    Toolchain('cxx17', ''),
    Toolchain('android-ndk-r10e-api-8-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-x86-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-16-x86-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon-c11', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon-hid-sections-lto', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-19-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-armeabi', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-gcc-49', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-gcc-49-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-arm64-v8a-clang-35', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-64', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-64-hid', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-x86-64-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-mips', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-mips64', 'Unix Makefiles'),
    Toolchain('android-ndk-r10e-api-21-mips-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-8-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-cxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-cxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r11c-api-16-armeabi-v7a-neon-cxx14', 'Unix Makefiles'),
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
    Toolchain('android-ndk-r12b-api-19-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r13b-api-19-armeabi-v7a-neon', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-16-armeabi-v7a-neon-clang-hid-sections-lto', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-19-armeabi-v7a-neon-c11', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-19-armeabi-v7a-neon-clang', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-19-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-21-arm64-v8a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-19-armeabi-v7a-neon-hid-sections-lto', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-21-arm64-v8a-clang-hid-sections-lto', 'Unix Makefiles'),
    Toolchain('android-ndk-r14-api-21-x86-64', 'Unix Makefiles'),
    Toolchain('android-ndk-r14b-api-21-armeabi-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r14b-api-21-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r14b-api-21-mips-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r14b-api-21-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-16-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-16-armeabi-v7a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-16-armeabi-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-16-mips-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-16-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-arm64-v8a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-arm64-v8a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-armeabi-v7a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-armeabi-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-mips-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-21-x86-64-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r15c-api-24-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-16-armeabi-v7a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-16-armeabi-v7a-thumb-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-16-x86-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-19-gcc-49-armeabi-v7a-neon-libcxx-hid-sections-lto', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-v7a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-arm64-v8a-neon-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-armeabi-v7a-neon-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-21-x86-64-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-24-arm64-v8a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-24-armeabi-v7a-neon-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-24-x86-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r16b-api-24-x86-64-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-24-arm64-v8a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-24-arm64-v8a-clang-libcxx11', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-21-arm64-v8a-neon-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-16-armeabi-v7a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-16-x86-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-21-x86-64-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-19-armeabi-v7a-neon-hid-sections', 'Unix Makefiles'),
    Toolchain('android-ndk-r17-api-19-armeabi-v7a-neon-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r18-api-24-arm64-v8a-clang-libcxx14', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-24-arm64-v8a-clang-libcxx11', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-28-arm64-v8a-clang-libcxx11', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-16-armeabi-v7a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-21-arm64-v8a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-21-armeabi-v7a-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-21-x86-64-clang-libcxx', 'Unix Makefiles'),
    Toolchain('android-ndk-r18b-api-21-x86-clang-libcxx', 'Unix Makefiles'),
    Toolchain('emscripten-cxx11', 'Unix Makefiles'),
    Toolchain('emscripten-cxx14', 'Unix Makefiles'),
    Toolchain('emscripten-cxx17', 'Unix Makefiles'),
    Toolchain('raspberrypi1-cxx11-pic', 'Unix Makefiles'),
    Toolchain('raspberrypi1-cxx11-pic-static-std', 'Unix Makefiles'),
    Toolchain('raspberrypi1-cxx14-pic-static-std', 'Unix Makefiles'),
    Toolchain('raspberrypi2-cxx11', 'Unix Makefiles'),
    Toolchain('raspberrypi2-cxx11-pic', 'Unix Makefiles'),
    Toolchain('raspberrypi3-clang-cxx11', 'Unix Makefiles'),
    Toolchain('raspberrypi3-clang-cxx14', 'Unix Makefiles'),
    Toolchain('raspberrypi3-clang-cxx14-pic', 'Unix Makefiles'),
    Toolchain('raspberrypi3-gcc-pic-hid-sections', 'Unix Makefiles'),
    Toolchain('raspberrypi3-cxx14', 'Unix Makefiles'),
    Toolchain('raspberrypi3-cxx11', 'Unix Makefiles')
]

if os.name == 'nt':
  toolchain_table += [
      Toolchain('mingw', 'MinGW Makefiles'),
      Toolchain('mingw-c11', 'MinGW Makefiles'),
      Toolchain('mingw-cxx14', 'MinGW Makefiles'),
      Toolchain('mingw-cxx17', 'MinGW Makefiles'),
      Toolchain('msys', 'MSYS Makefiles'),
      Toolchain('msys-cxx14', 'MSYS Makefiles'),
      Toolchain('msys-cxx17', 'MSYS Makefiles'),
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
          'nmake-vs-15-2017-win64',
          'NMake Makefiles',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'nmake-vs-15-2017-win64-cxx17',
          'NMake Makefiles',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'nmake-vs-15-2017-win64-cxx17-nonpermissive',
          'NMake Makefiles',
          arch='amd64',
          vs_version='15'
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
          'ninja-vs-15-2017-win64',
          'Ninja',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'ninja-vs-15-2017-win64-cxx17',
          'Ninja',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'ninja-vs-15-2017-win64-cxx17-nonpermissive',
          'Ninja',
          arch='amd64',
          vs_version='15'
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
          'vs-15-2017', 'Visual Studio 15 2017', arch='x86', vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-mt', 'Visual Studio 15 2017', arch='x86', vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-cxx14-mt', 'Visual Studio 15 2017', arch='x86', vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-cxx17', 'Visual Studio 15 2017', arch='x86', vs_version='15'
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
          'vs-15-2017-win64',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-mt',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-cxx14-mt',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-cxx14',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-cxx17',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-cxx17-nonpermissive',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-llvm',
          'Visual Studio 15 2017 Win64',
          toolset='llvm',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-llvm-vs2014',
          'Visual Studio 15 2017 Win64',
          toolset='LLVM-vs2014',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-store-10-zw',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-store-10-zw',
          'Visual Studio 15 2017',
          arch='x86',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-store-10-cxx17',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-z7',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15'
      ),
      Toolchain(
          'vs-15-2017-win64-version-14-11',
          'Visual Studio 15 2017 Win64',
          arch='amd64',
          vs_version='15',
          toolset='version=14.11'
      ),
      Toolchain(
          'vs-16-2019',
          'Visual Studio 16 2019',
          arch='x86',
          vs_version='16'
      ),
      Toolchain(
          'vs-16-2019-cxx14',
          'Visual Studio 16 2019',
          arch='x86',
          vs_version='16'
      ),
      Toolchain(
          'vs-16-2019-cxx17',
          'Visual Studio 16 2019',
          arch='x86',
          vs_version='16'
      ),
      Toolchain(
          'vs-16-2019-win64',
          'Visual Studio 16 2019',
          arch='amd64',
          vs_version='16'
      ),
      Toolchain(
          'vs-16-2019-win64-cxx14',
          'Visual Studio 16 2019',
          arch='amd64',
          vs_version='16'
      ),
      Toolchain(
          'vs-16-2019-win64-cxx17',
          'Visual Studio 16 2019',
          arch='amd64',
          vs_version='16'
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
      Toolchain('sanitize-leak-cxx17', 'Unix Makefiles'),
      Toolchain('sanitize-leak-cxx17-pic', 'Unix Makefiles'),
      Toolchain('sanitize-memory', 'Unix Makefiles'),
      Toolchain('linux-mingw-w32', 'Unix Makefiles'),
      Toolchain('linux-mingw-w32-cxx14', 'Unix Makefiles'),
      Toolchain('linux-mingw-w64', 'Unix Makefiles'),
      Toolchain('linux-mingw-w64-cxx14', 'Unix Makefiles'),
      Toolchain('linux-mingw-w64-cxx98', 'Unix Makefiles'),
      Toolchain('linux-mingw-w64-gnuxx11', 'Unix Makefiles'),
      Toolchain('linux-gcc-armhf', 'Unix Makefiles'),
      Toolchain('linux-gcc-armhf-neon', 'Unix Makefiles'),
      Toolchain('linux-gcc-armhf-neon-vfpv4', 'Unix Makefiles'),
      Toolchain('linux-gcc-jetson-tk1', 'Unix Makefiles'),
  ]

if platform.system() == 'Darwin':
  toolchain_table += [
      Toolchain('ios', 'Xcode'),
      Toolchain('ios-cxx17', 'Xcode'),
      Toolchain('ios-bitcode', 'Xcode'),
      Toolchain('ios-13-2-dep-10-0-arm64-bitcode-cxx17', 'Xcode', ios_version='13.2'),
      Toolchain('ios-13-2-dep-9-3-arm64-bitcode', 'Xcode', ios_version='13.2'),
      Toolchain('ios-13-2-dep-9-3-device-bitcode-cxx14', 'Xcode', ios_version='13.2'),
      Toolchain('ios-13-0-dep-9-3-arm64', 'Xcode', ios_version='13.0'),
      Toolchain('ios-13-0-dep-9-3-arm64-bitcode', 'Xcode', ios_version='13.0'),
      Toolchain('ios-13-0-dep-11-0-arm64-bitcode-cxx17', 'Xcode', ios_version='13.0'),
      Toolchain('ios-13-0-dep-10-0-arm64-bitcode-cxx17', 'Xcode', ios_version='13.0'),
      Toolchain('ios-12-3-dep-9-3-arm64', 'Xcode', ios_version='12.3'),
      Toolchain('ios-12-2-dep-9-3-arm64', 'Xcode', ios_version='12.2'),
      Toolchain('ios-12-1-dep-9-0-device-bitcode-cxx14', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-0-device-bitcode-cxx17', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-0-dep-11-0-arm64', 'Xcode', ios_version='12.0'),
      Toolchain('ios-12-1-dep-11-0-arm64', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-12-0-arm64-cxx17', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-3-arm64-bitcode', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-3-arm64', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-3-armv7', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-3', 'Xcode', ios_version='12.1'),
      Toolchain('ios-12-1-dep-9-3-x86-64-arm64', 'Xcode', ios_version='12.1'),
      Toolchain('ios-11-4-dep-9-3-arm64', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-9-3-armv7', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-9-3-arm64-armv7', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-9-3', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-9-4-arm64', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-9-3-arm64-hid-sections-lto-cxx11', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-8-0-arm64-armv7-hid-sections-lto-cxx11', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-4-dep-8-0-arm64-hid-sections-lto-cxx11', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-3-dep-9-0-arm64', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-4-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='11.4'),
      Toolchain('ios-12-0-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='12.0'),
      Toolchain('ios-11-4-dep-9-0-device-bitcode-nocxx', 'Xcode', ios_version='11.4'),
      Toolchain('ios-11-3-dep-9-0-device-bitcode', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-3-dep-9-0-device-bitcode-nocxx', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-3-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-3-dep-9-0-device-bitcode-cxx17', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-2-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='11.2'),
      Toolchain('ios-11-2-dep-9-0-device-bitcode-nocxx', 'Xcode', ios_version='11.2'),
      Toolchain('ios-11-2-dep-9-3-arm64-armv7', 'Xcode', ios_version='11.2'),
      Toolchain('ios-11-3-dep-9-3-arm64-armv7', 'Xcode', ios_version='11.3'),
      Toolchain('ios-11-1-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.1'),
      Toolchain('ios-11-1-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='11.1'),
      Toolchain('ios-11-0-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.0'),
      Toolchain('ios-11-0-dep-9-0-device-bitcode-cxx11', 'Xcode', ios_version='11.0'),
      Toolchain('ios-11-0-dep-9-0-x86-64-arm64-bitcode-cxx11', 'Xcode', ios_version='11.0'),
      Toolchain('ios-11-0', 'Xcode', ios_version='11.0'),
      Toolchain('ios-10-3', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-dep-8-0-bitcode', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-dep-9-0-bitcode', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-dep-9-3-i386-armv7', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-dep-9-3-x86-64-arm64', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-lto', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-armv7', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-3-arm64', 'Xcode', ios_version='10.3'),
      Toolchain('ios-10-2', 'Xcode', ios_version='10.2'),
      Toolchain('ios-10-2-dep-9-3-armv7', 'Xcode', ios_version='10.2'),
      Toolchain('ios-10-2-dep-9-3-arm64', 'Xcode', ios_version='10.2'),
      Toolchain('ios-10-1', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-arm64', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-arm64-dep-8-0-hid-sections', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-armv7', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-dep-8-0-hid-sections', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-dep-8-0-libcxx-hid-sections', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-dep-8-0-libcxx-hid-sections-lto', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-1-wo-armv7s', 'Xcode', ios_version='10.1'),
      Toolchain('ios-10-0', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-arm64', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-arm64-dep-8-0-hid-sections', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-armv7', 'Xcode', ios_version='10.0'),
      Toolchain('ios-10-0-dep-8-0-hid-sections', 'Xcode', ios_version='10.0'),
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
      Toolchain('ios-dep-8-0-arm64-cxx11', 'Xcode'),
      Toolchain('ios-dep-8-0-arm64-armv7-hid-sections-cxx11', 'Xcode'),
      Toolchain('ios-dep-8-0-arm64-armv7-hid-sections-lto-cxx11', 'Xcode'),
      Toolchain('ios-dep-10-0-bitcode-cxx17', 'Xcode'),
      Toolchain('ios-nocodesign', 'Xcode', nocodesign=True),
      Toolchain('ios-nocodesign-arm64', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-armv7', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-hid-sections', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-wo-armv7s', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-8-4', 'Xcode', ios_version='8.4', nocodesign=True),
      Toolchain('ios-nocodesign-8-1', 'Xcode', ios_version='8.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-1', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-1-arm64', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-1-armv7', 'Xcode', ios_version='9.1', nocodesign=True),
      Toolchain('ios-nocodesign-9-2', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-2-arm64', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-2-armv7', 'Xcode', ios_version='9.2', nocodesign=True),
      Toolchain('ios-nocodesign-9-3', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-device', 'Xcode', ios_version='9.3', nocodesign=True),
      Toolchain('ios-nocodesign-9-3-device-hid-sections', 'Xcode', ios_version='9.3', nocodesign=True),
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
      Toolchain('ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections-lto', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-arm64-dep-9-0-device-libcxx-hid-sections', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-dep-8-0-libcxx-hid-sections-lto', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-dep-8-0-device-libcxx-hid-sections-lto', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-1-dep-9-0-device-libcxx-hid-sections-lto', 'Xcode', ios_version='10.1', nocodesign=True),
      Toolchain('ios-nocodesign-10-2', 'Xcode', ios_version='10.2', nocodesign=True),
      Toolchain('ios-nocodesign-10-3', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-cxx14', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-arm64-dep-9-0-device-libcxx-hid-sections', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-dep-9-0-bitcode', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-wo-armv7s', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-arm64', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-10-3-armv7', 'Xcode', ios_version='10.3', nocodesign=True),
      Toolchain('ios-nocodesign-11-0', 'Xcode', ios_version='11.0', nocodesign=True),
      Toolchain('ios-nocodesign-11-0-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.0', nocodesign=True),
      Toolchain('ios-nocodesign-11-0-arm64-dep-9-0-device-libcxx-hid-sections', 'Xcode', ios_version='11.0', nocodesign=True),
      Toolchain('ios-nocodesign-11-1', 'Xcode', ios_version='11.1', nocodesign=True),
      Toolchain('ios-nocodesign-11-1-dep-9-0-wo-armv7s-bitcode-cxx11', 'Xcode', ios_version='11.1', nocodesign=True),
      Toolchain('ios-nocodesign-11-1-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.1', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-8-0-wo-armv7s-bitcode-cxx11', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-3', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-3-armv7', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-3-arm64', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-3-arm64-armv7', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2-dep-9-3-i386-armv7', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-2', 'Xcode', ios_version='11.2', nocodesign=True),
      Toolchain('ios-nocodesign-11-3-dep-9-3', 'Xcode', ios_version='11.3', nocodesign=True),
      Toolchain('ios-nocodesign-11-3-dep-9-3-armv7', 'Xcode', ios_version='11.3', nocodesign=True),
      Toolchain('ios-nocodesign-11-3-dep-9-3-arm64', 'Xcode', ios_version='11.3', nocodesign=True),
      Toolchain('ios-nocodesign-11-3-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.3', nocodesign=True),
      Toolchain('ios-nocodesign-11-4-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='11.4', nocodesign=True),
      Toolchain('ios-nocodesign-12-0-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='12.0', nocodesign=True),
      Toolchain('ios-nocodesign-12-0-dep-10-0-bitcode-cxx11', 'Xcode', ios_version='12.0', nocodesign=True),
      Toolchain('ios-nocodesign-12-1-dep-9-0-bitcode-cxx11', 'Xcode', ios_version='12.1', nocodesign=True),
      Toolchain('ios-nocodesign-11-4-dep-9-3', 'Xcode', ios_version='11.4', nocodesign=True),
      Toolchain('ios-nocodesign-11-4-dep-9-3-arm64', 'Xcode', ios_version='11.4', nocodesign=True),
      Toolchain('ios-nocodesign-11-4-dep-9-3-armv7', 'Xcode', ios_version='11.4', nocodesign=True),
      Toolchain('ios-nocodesign-12-1-dep-9-3-armv7', 'Xcode', ios_version='12.1', nocodesign=True),
      Toolchain('ios-nocodesign-12-1', 'Xcode', ios_version='12.1', nocodesign=True),
      Toolchain('ios-nocodesign-13-0-dep-9-3-arm64', 'Xcode', ios_version='13.0', nocodesign=True),
      Toolchain('ios-nocodesign-13-2-dep-9-3-arm64', 'Xcode', ios_version='13.2', nocodesign=True),
      Toolchain('ios-nocodesign-13-2-dep-9-3', 'Xcode', ios_version='13.2', nocodesign=True),
      Toolchain('ios-nocodesign-dep-9-0-cxx14', 'Xcode', nocodesign=True),
      Toolchain('xcode', 'Xcode'),
      Toolchain('xcode-cxx98', 'Xcode'),
      Toolchain('xcode-cxx17', 'Xcode'),
      Toolchain('xcode-nocxx', 'Xcode'),
      Toolchain('xcode-gcc', 'Xcode'),
      Toolchain('xcode-hid-sections', 'Xcode'),
      Toolchain('xcode-sections', 'Xcode'),
      Toolchain('osx-10-7', 'Xcode', osx_version='10.7'),
      Toolchain('osx-10-8', 'Xcode', osx_version='10.8'),
      Toolchain('osx-10-9', 'Xcode', osx_version='10.9'),
      Toolchain('osx-10-10', 'Xcode', osx_version='10.10'),
      Toolchain('osx-10-11', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-11-hid-sections', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-11-hid-sections-lto', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-11-lto', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-12', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-hid-sections', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-lto', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-cxx98', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-cxx14', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-cxx17', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-10-dep-10-7', 'Xcode', osx_version='10.10'),
      Toolchain('osx-10-12-dep-10-10', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-dep-10-10-lto', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-10-dep-10-9-make', 'Unix Makefiles'),
      Toolchain('osx-10-11-make', 'Unix Makefiles'),
      Toolchain('osx-10-12-make', 'Unix Makefiles'),
      Toolchain('osx-10-12-ninja', 'Ninja'),
      Toolchain('osx-10-11-sanitize-address', 'Xcode', osx_version='10.11'),
      Toolchain('osx-10-12-sanitize-address', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-12-sanitize-address-hid-sections', 'Xcode', osx_version='10.12'),
      Toolchain('osx-10-13', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-10', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-10-cxx14', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-10-cxx17', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-12', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-12-cxx14', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-dep-10-12-cxx17', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-make-cxx14', 'Unix Makefiles'),
      Toolchain('osx-10-13-cxx14', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-cxx17', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-13-i386-cxx14', 'Xcode', osx_version='10.13'),
      Toolchain('osx-10-14', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-10', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-10-cxx14', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-10-cxx17', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-12', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-12-cxx14', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-dep-10-12-cxx17', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-cxx14', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-14-cxx17', 'Xcode', osx_version='10.14'),
      Toolchain('osx-10-15', 'Xcode', osx_version='10.15'),
      Toolchain('osx-10-15-cxx17', 'Xcode', osx_version='10.15'),
      Toolchain('osx-10-15-dep-10-10', 'Xcode', osx_version='10.15'),
      Toolchain('osx-10-15-dep-10-10-cxx14', 'Xcode', osx_version='10.15'),
      Toolchain('osx-10-15-dep-10-10-cxx17', 'Xcode', osx_version='10.15'),
      Toolchain('osx-10-15-dep-10-12-cxx17', 'Xcode', osx_version='10.15'),
      Toolchain('linux-gcc-x64', 'Unix Makefiles'),
  ]

if os.name == 'posix':
  toolchain_table += [
      Toolchain('analyze', 'Unix Makefiles'),
      Toolchain('analyze-cxx17', 'Unix Makefiles'),
      Toolchain('clang-5', 'Unix Makefiles'),
      Toolchain('clang-5-cxx14', 'Unix Makefiles'),
      Toolchain('clang-5-cxx17', 'Unix Makefiles'),
      Toolchain('clang-cxx20', 'Unix Makefiles'),
      Toolchain('clang-cxx17', 'Unix Makefiles'),
      Toolchain('clang-cxx17-pic', 'Unix Makefiles'),
      Toolchain('clang-cxx14', 'Unix Makefiles'),
      Toolchain('clang-cxx14-pic', 'Unix Makefiles'),
      Toolchain('clang-cxx11', 'Unix Makefiles'),
      Toolchain('clang-libcxx', 'Unix Makefiles'),
      Toolchain('clang-libcxx-fpic', 'Unix Makefiles'),
      Toolchain('clang-libcxx14', 'Unix Makefiles'),
      Toolchain('clang-libcxx14-fpic', 'Unix Makefiles'),
      Toolchain('clang-libcxx17', 'Unix Makefiles'),
      Toolchain('clang-libcxx17-fpic', 'Unix Makefiles'),
      Toolchain('clang-libcxx98', 'Unix Makefiles'),
      Toolchain('clang-libcxx17-static', 'Unix Makefiles'),
      Toolchain('clang-lto', 'Unix Makefiles'),
      Toolchain('clang-libstdcxx', 'Unix Makefiles'),
      Toolchain('clang-omp', 'Unix Makefiles'),
      Toolchain('clang-fpic', 'Unix Makefiles'),
      Toolchain('clang-fpic-hid-sections', 'Unix Makefiles'),
      Toolchain('clang-fpic-static-std', 'Unix Makefiles'),
      Toolchain('clang-fpic-static-std-cxx14', 'Unix Makefiles'),
      Toolchain('clang-tidy', 'Unix Makefiles'),
      Toolchain('clang-tidy-libcxx', 'Unix Makefiles'),
      Toolchain('gcc', 'Unix Makefiles'),
      Toolchain('gcc-ninja', 'Ninja'),
      Toolchain('gcc-static', 'Unix Makefiles'),
      Toolchain('gcc-static-std', 'Unix Makefiles'),
      Toolchain('gcc-musl', 'Unix Makefiles'),
      Toolchain('gcc-32bit', 'Unix Makefiles'),
      Toolchain('gcc-32bit-pic', 'Unix Makefiles'),
      Toolchain('gcc-hid', 'Unix Makefiles'),
      Toolchain('gcc-hid-fpic', 'Unix Makefiles'),
      Toolchain('gcc-gold', 'Unix Makefiles'),
      Toolchain('gcc-pic', 'Unix Makefiles'),
      Toolchain('gcc-c11', 'Unix Makefiles'),
      Toolchain('gcc-cxx14-c11', 'Unix Makefiles'),
      Toolchain('gcc-cxx17-c11', 'Unix Makefiles'),
      Toolchain('gcc-4-8', 'Unix Makefiles'),
      Toolchain('gcc-4-8-c11', 'Unix Makefiles'),
      Toolchain('gcc-4-8-pic', 'Unix Makefiles'),
      Toolchain('gcc-4-8-pic-hid-sections', 'Unix Makefiles'),
      Toolchain('gcc-4-8-pic-hid-sections-cxx11-c11', 'Unix Makefiles'),
      Toolchain('gcc-pic-hid-sections', 'Unix Makefiles'),
      Toolchain('gcc-pic-hid-sections-lto', 'Unix Makefiles'),
      Toolchain('gcc-5-pic-hid-sections-lto', 'Unix Makefiles'),
      Toolchain('gcc-5-pic-hid-sections', 'Unix Makefiles'),
      Toolchain('gcc-5', 'Unix Makefiles'),
      Toolchain('gcc-5-cxx14-c11', 'Unix Makefiles'),
      Toolchain('gcc-6-32bit-cxx14', 'Unix Makefiles'),
      Toolchain('gcc-7', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx11-pic', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx14', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx14-pic', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx17', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx17-gnu', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx17-pic', 'Unix Makefiles'),
      Toolchain('gcc-7-cxx17-concepts', 'Unix Makefiles'),
      Toolchain('gcc-7-pic-hid-sections-lto', 'Unix Makefiles'),
      Toolchain('gcc-8-cxx14', 'Unix Makefiles'),
      Toolchain('gcc-8-cxx14-fpic', 'Unix Makefiles'),
      Toolchain('gcc-8-cxx17', 'Unix Makefiles'),
      Toolchain('gcc-8-cxx17-fpic', 'Unix Makefiles'),
      Toolchain('gcc-8-cxx17-concepts', 'Unix Makefiles'),
      Toolchain('gcc-cxx98', 'Unix Makefiles'),
      Toolchain('gcc-lto', 'Unix Makefiles'),
      Toolchain('libcxx', 'Unix Makefiles'),
      Toolchain('libcxx14', 'Unix Makefiles'),
      Toolchain('libcxx-no-sdk', 'Unix Makefiles'),
      Toolchain('libcxx-hid', 'Unix Makefiles'),
      Toolchain('libcxx-hid-fpic', 'Unix Makefiles'),
      Toolchain('libcxx-fpic-hid-sections', 'Unix Makefiles'),
      Toolchain('libcxx-hid-sections', 'Unix Makefiles'),
      Toolchain('sanitize-address', 'Unix Makefiles'),
      Toolchain('sanitize-address-cxx17', 'Unix Makefiles'),
      Toolchain('sanitize-address-cxx17-pic', 'Unix Makefiles'),
      Toolchain('sanitize-thread', 'Unix Makefiles'),
      Toolchain('sanitize-thread-cxx17', 'Unix Makefiles'),
      Toolchain('sanitize-thread-cxx17-pic', 'Unix Makefiles'),
      Toolchain('arm-openwrt-linux-muslgnueabi', 'Unix Makefiles'),
      Toolchain('arm-openwrt-linux-muslgnueabi-cxx14', 'Unix Makefiles'),
      Toolchain('openbsd-egcc-cxx11-static-std', 'Unix Makefiles'),
      Toolchain('ninja-gcc-7-cxx17-concepts', 'Ninja'),
      Toolchain('ninja-gcc-8-cxx17-concepts', 'Ninja'),
  ]

def get_by_name(name):
  for x in toolchain_table:
    if name == x.name:
      return x
  sys.exit('Internal error: toolchain not found in toolchain table')
