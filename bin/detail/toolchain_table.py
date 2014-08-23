# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

class Toolchain:
  def __init__(self, name, generator):
    self.name = name
    self.generator = generator

toolchain_table = [
    Toolchain('analyze', 'Unix Makefiles'),
    Toolchain('clang-lto', 'Unix Makefiles'),
    Toolchain('clang_libstdcxx', 'Unix Makefiles'),
    Toolchain('cygwin', 'Unix Makefiles'),
    Toolchain('default', ''),
    Toolchain('gcc', 'Unix Makefiles'),
    Toolchain('gcc48', 'Unix Makefiles'),
    Toolchain('ios', 'Xcode'),
    Toolchain('ios-nocodesign', 'Xcode'),
    Toolchain('libcxx', 'Unix Makefiles'),
    Toolchain('mingw', 'MinGW Makefiles'),
    Toolchain('nmake-vs-12-2013', 'NMake Makefiles'),
    Toolchain('nmake-vs-12-2013-win64', 'NMake Makefiles'),
    Toolchain('sanitize_address', 'Unix Makefiles'),
    Toolchain('sanitize_leak', 'Unix Makefiles'),
    Toolchain('sanitize_memory', 'Unix Makefiles'),
    Toolchain('sanitize_thread', 'Unix Makefiles'),
    Toolchain('vs-12-2013', 'Visual Studio 12 2013'),
    Toolchain('vs-12-2013-win64', 'Visual Studio 12 2013 Win64'),
    Toolchain('xcode', 'Xcode'),
]
