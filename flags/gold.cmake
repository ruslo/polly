# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_GOLD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_GOLD_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fuse-ld=gold")
polly_add_cache_flag(CMAKE_C_FLAGS "-fuse-ld=gold")
