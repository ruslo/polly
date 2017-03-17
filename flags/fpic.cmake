# Copyright (c) 2015, Ruslan Baratov, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_FLAGS_FPIC_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_FPIC_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-fPIC")
  polly_add_cache_flag(CMAKE_C_FLAGS "-fPIC")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-fPIC")
  polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-fPIC")
endif()
