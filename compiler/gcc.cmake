# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_GCC_CMAKE)
  return()
else()
  set(POLLY_COMPILER_GCC_CMAKE 1)
endif()

set(CMAKE_C_COMPILER gcc CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER g++ CACHE STRING "C++ compiler" FORCE)
