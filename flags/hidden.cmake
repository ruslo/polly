# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_HIDDEN_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_HIDDEN_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-fvisibility=hidden")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-fvisibility-inlines-hidden") # only C++
  polly_add_cache_flag(CMAKE_C_FLAGS "-fvisibility=hidden")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-fvisibility=hidden")
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-fvisibility-inlines-hidden") # only C++
  polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-fvisibility=hidden")
endif()

# There is no macro to detect this flags on toolchain calculation so we must
# mark this toolchain explicitly.
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "hidden")
