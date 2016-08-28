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
