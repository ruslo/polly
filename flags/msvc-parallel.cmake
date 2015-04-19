# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_MSVC_PARALLEL_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_MSVC_PARALLEL_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

if(POLLY_PARALLEL)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "/MP")
  polly_add_cache_flag(CMAKE_C_FLAGS "/MP")
endif()
