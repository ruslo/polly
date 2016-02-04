# Copyright (c) 2015, Ruslan Baratov, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_FLAGS_FPIC_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_FPIC_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fPIC")
polly_add_cache_flag(CMAKE_C_FLAGS "-fPIC")
