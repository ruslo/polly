# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import platform

class Toolchain:
  def __init__(self, name, generator):
    self.name = name
    self.generator = generator

toolchain_table = [Toolchain('default', '')]

if os.name == 'nt':
  toolchain_table += [
      Toolchain('mingw', 'MinGW Makefiles'),
      Toolchain('nmake-vs-12-2013', 'NMake Makefiles'),
      Toolchain('nmake-vs-12-2013-win64', 'NMake Makefiles'),
      Toolchain('vs-12-2013', 'Visual Studio 12 2013'),
      Toolchain('vs-12-2013-win64', 'Visual Studio 12 2013 Win64'),
  ]

if platform.system().startswith('CYGWIN'):
  toolchain_table += [
      Toolchain('cygwin', 'Unix Makefiles'),
  ]

if platform.system() == 'Linux':
  toolchain_table += [
      Toolchain('sanitize_leak', 'Unix Makefiles'),
      Toolchain('sanitize_memory', 'Unix Makefiles'),
      Toolchain('sanitize_thread', 'Unix Makefiles'),
  ]

if platform.system() == 'Darwin':
  toolchain_table += [
      Toolchain('ios', 'Xcode'),
      Toolchain('ios-nocodesign', 'Xcode'),
      Toolchain('xcode', 'Xcode'),
  ]

if os.name == 'posix':
  toolchain_table += [
      Toolchain('analyze', 'Unix Makefiles'),
      Toolchain('clang-lto', 'Unix Makefiles'),
      Toolchain('clang_libstdcxx', 'Unix Makefiles'),
      Toolchain('gcc', 'Unix Makefiles'),
      Toolchain('gcc48', 'Unix Makefiles'),
      Toolchain('libcxx', 'Unix Makefiles'),
      Toolchain('sanitize_address', 'Unix Makefiles'),
  ]
