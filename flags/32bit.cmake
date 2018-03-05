# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_32BIT_CMAKE)
  return()
else()
  set(POLLY_FLAGS_32BIT_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-m32")
polly_add_cache_flag(CMAKE_C_FLAGS "-m32")
