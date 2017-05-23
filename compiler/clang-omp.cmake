# Copyright (c) 2013-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_CLANG_OMP_CMAKE)
  return()
else()
  set(POLLY_COMPILER_CLANG_OMP_CMAKE 1)
endif()

include(polly_add_cache_flag)
include(polly_fatal_error)

if(XCODE_VERSION)
  set(_err "This toolchain is not available for Xcode")
  set(_err "${_err} because Xcode ignores CMAKE_C(XX)_COMPILER variable.")
  set(_err "${_err} Use xcode.cmake toolchain instead.")
  polly_fatal_error(${_err})
endif()

string(COMPARE EQUAL "$ENV{CLANG_OMP_ROOT}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("Environment variable CLANG_OMP_ROOT is not set")
endif()

if(NOT EXISTS "$ENV{CLANG_OMP_ROOT}/bin")
  polly_fatal_error("Directory '$ENV{CLANG_OMP_ROOT}/bin' not exists (please check CLANG_OMP_ROOT)")
endif()

unset(CMAKE_C_COMPILER CACHE)
unset(CMAKE_CXX_COMPILER CACHE)

find_program(
    CMAKE_C_COMPILER
    clang
    PATHS "$ENV{CLANG_OMP_ROOT}/bin"
    NO_DEFAULT_PATH
)

find_program(
    CMAKE_CXX_COMPILER
    clang++
    PATHS "$ENV{CLANG_OMP_ROOT}/bin"
    NO_DEFAULT_PATH
)

if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("clang not found (verify CLANG_OMP_ROOT)")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("clang++ not found (verify CLANG_OMP_ROOT)")
endif()

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fopenmp")
polly_add_cache_flag(CMAKE_C_FLAGS "-fopenmp")

polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-L$ENV{CLANG_OMP_ROOT}/lib")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-L$ENV{CLANG_OMP_ROOT}/lib")
