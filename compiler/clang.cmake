# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_CLANG_CMAKE)
  return()
else()
  set(POLLY_COMPILER_CLANG_CMAKE 1)
endif()

include(polly_fatal_error)

if(XCODE_VERSION)
  set(_err "This toolchain is not available for Xcode")
  set(_err "${_err} because Xcode ignores CMAKE_C(XX)_COMPILER variable.")
  set(_err "${_err} Use xcode.cmake toolchain instead.")
  polly_fatal_error(${_err})
endif()

set(CMAKE_C_COMPILER clang CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER clang++ CACHE STRING "C++ compiler" FORCE)
