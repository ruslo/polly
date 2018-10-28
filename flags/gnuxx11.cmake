# Copyright (c) 2018, NeroBurner
# All rights reserved.

if(DEFINED POLLY_FLAGS_GNUXX11_CMAKE)
  return()
else()
  set(POLLY_FLAGS_GNUXX11_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=gnu++11")

# Set CMAKE_CXX_STANDARD to cache to override project local value if present.
# FORCE added in case CMAKE_CXX_STANDARD already set in cache
# (e.g. set before 'project' by user).
set(CMAKE_CXX_STANDARD 11 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
