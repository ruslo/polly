# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX11_CMAKE)
  return()
else()
  set(POLLY_FLAGS_CXX11_CMAKE 1)
endif()

include(polly_add_cache_flag)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=c++11")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-std=c++11")
endif()

# Set CMAKE_CXX_STANDARD to cache to override project local value if present.
# FORCE added in case CMAKE_CXX_STANDARD already set in cache
# (e.g. set before 'project' by user).
set(CMAKE_CXX_STANDARD 11 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
set(CMAKE_CXX_EXTENSIONS NO CACHE BOOL "C++ Standard extensions" FORCE)
