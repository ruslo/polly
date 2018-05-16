# Copyright (c) 2018, NeroBurner
# All rights reserved.

if(DEFINED POLLY_FLAGS_GNUXX11_CMAKE)
  return()
else()
  set(POLLY_FLAGS_GNUXX11_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=gnu++11")
