# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX98_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CXX98_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-std=c++98")
