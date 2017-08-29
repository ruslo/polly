# Copyright (c) 2013-2016, Ruslan Baratov
# Copyright (c) 2016, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_FLAGS_FUNCTION_SECTIONS_CMAKE)
  return()
else()
  set(POLLY_FLAGS_FUNCTION_SECTIONS_CMAKE 1)
endif()

include(polly_add_cache_flag)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-ffunction-sections")
  polly_add_cache_flag(CMAKE_C_FLAGS "-ffunction-sections")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-ffunction-sections")
  polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-ffunction-sections")
endif()

# There is no macro to detect this flags on toolchain calculation so we must
# mark this toolchain explicitly.
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "function-sections")
