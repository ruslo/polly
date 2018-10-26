# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX98_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CXX98_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=c++98")

# Set CMAKE_CXX_STANDARD to cache to override project local value if present.
# FORCE added in case CMAKE_CXX_STANDARD already set in cache
# (e.g. set before 'project' by user).
set(CMAKE_CXX_STANDARD 98 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
set(CMAKE_CXX_EXTENSIONS NO CACHE BOOL "C++ Standard extensions" FORCE)
