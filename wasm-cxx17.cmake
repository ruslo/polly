# Copyright (c) 2016-2017, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# Copyright (c) 2018, Damien Buhl
# All rights reserved.

if(DEFINED POLLY_WASM_CXX17_CMAKE_)
  return()
else()
  set(POLLY_WASM_CXX17_CMAKE_ 1)
endif()

#include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

#polly_init(
#    "wasm / c++17 support"
#    "Unix Makefiles"
#)
#
include("${CMAKE_CURRENT_LIST_DIR}/wasm.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_add_cache_flag.cmake")
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-std=c++17")

# Set CMAKE_CXX_STANDARD to cache to override project local value if present.
# FORCE added in case CMAKE_CXX_STANDARD already set in cache
# (e.g. set before 'project' by user).
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
set(CMAKE_CXX_EXTENSIONS NO CACHE BOOL "C++ Standard extensions" FORCE)
