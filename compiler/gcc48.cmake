# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_GCC48_CMAKE)
  return()
else()
  set(POLLY_COMPILER_GCC48_CMAKE 1)
endif()

set(CMAKE_C_COMPILER gcc-4.8 CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER g++-4.8 CACHE STRING "C++ compiler" FORCE)
