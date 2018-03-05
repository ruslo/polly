# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_EGCC_CMAKE)
  return()
else()
  set(POLLY_COMPILER_EGCC_CMAKE 1)
endif()

include(polly_fatal_error)

if(XCODE_VERSION)
  set(_err "This toolchain is not available for Xcode")
  set(_err "${_err} because Xcode ignores CMAKE_C(XX)_COMPILER variable.")
  set(_err "${_err} Use xcode.cmake toolchain instead.")
  polly_fatal_error(${_err})
endif()

find_program(CMAKE_C_COMPILER egcc)
find_program(CMAKE_CXX_COMPILER eg++)
find_program(CMAKE_CPP_COMPILER egcpp)

if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("egcc not found")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("eg++ not found")
endif()

set(
    CMAKE_C_COMPILER
    "${CMAKE_C_COMPILER}"
    CACHE
    STRING
    "C compiler"
    FORCE
)

set(
    CMAKE_CXX_COMPILER
    "${CMAKE_CXX_COMPILER}"
    CACHE
    STRING
    "C++ compiler"
    FORCE
)
