# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_LTO_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_LTO_CMAKE_ 1)
endif()

include(polly_fatal_error)

if(NOT POLICY CMP0069)
  polly_fatal_error("Bad CMake version")
endif()

set(CMAKE_INTERPROCEDURAL_OPTIMIZATION YES)
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "lto.v2")
