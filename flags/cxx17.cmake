# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX17_CMAKE)
  return()
else()
  set(POLLY_FLAGS_CXX17_CMAKE 1)
endif()

include(polly_add_cache_flag)
include(polly_fatal_error)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(HUNTER_CMAKE_GENERATOR MATCHES "^Visual Studio.*$")
  polly_fatal_error("Use flags/vs-cxx17.cmake instead")
elseif(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=c++17")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-std=c++17")
endif()

# Set CMAKE_CXX_STANDARD to cache to override project local value if present.
# FORCE added in case CMAKE_CXX_STANDARD already set in cache
# (e.g. set before 'project' by user).
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
set(CMAKE_CXX_EXTENSIONS NO CACHE BOOL "C++ Standard extensions" FORCE)
