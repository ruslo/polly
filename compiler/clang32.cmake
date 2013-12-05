# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_CLANG32_CMAKE)
  return()
else()
  set(POLLY_COMPILER_CLANG32_CMAKE 1)
endif()

set(CMAKE_C_COMPILER clang-3.2 CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER clang++-3.2 CACHE STRING "C++ compiler" FORCE)
