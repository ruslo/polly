# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import platform

class Toolchain:
  def __init__(self, name, generator, arch='', vs_version='', ios_version=''):
    self.name = name
    self.generator = generator
    self.arch = arch
    self.vs_version = vs_version
    self.ios_version = ios_version
    self.is_nmake = (self.generator == 'NMake Makefiles')
    self.is_msvc = self.generator.startswith('Visual Studio')
    self.is_xcode = (self.generator == 'Xcode')
    self.multiconfig = (self.is_xcode or self.is_msvc)
    self.verify()

  def verify(self):
    if self.arch:
      assert(self.is_nmake or self.is_msvc)
      assert(self.arch == 'amd64' or self.arch == 'x86')

    if self.is_nmake or self.is_msvc:
      assert(self.vs_version)

    if self.ios_version:
      assert(self.generator == 'Xcode')

toolchain_table = [Toolchain('default', '')]

if os.name == 'nt':
  toolchain_table += [
      Toolchain('mingw', 'MinGW Makefiles'),
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
      Toolchain('ios-8-0', 'Xcode', ios_version='8.0'),
      Toolchain('ios-7-1', 'Xcode', ios_version='7.1'),
      Toolchain('ios-7-0', 'Xcode', ios_version='7.0'),
      Toolchain('ios-nocodesign', 'Xcode', ios_version='7.1'),
      Toolchain('xcode', 'Xcode'),
  ]

if os.name == 'posix':
  toolchain_table += [
      Toolchain('analyze', 'Unix Makefiles'),
      Toolchain('clang-lto', 'Unix Makefiles'),
      Toolchain('clang-libstdcxx', 'Unix Makefiles'),
      Toolchain('gcc', 'Unix Makefiles'),
      Toolchain('gcc-4-8', 'Unix Makefiles'),
      Toolchain('libcxx', 'Unix Makefiles'),
      Toolchain('sanitize-address', 'Unix Makefiles'),
  ]

def get_by_name(name):
  for x in toolchain_table:
    if name == x.name:
      return x
  sys.exit('Internal error: toolchain not found in toolchain table')
