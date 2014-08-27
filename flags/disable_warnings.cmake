# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_DISABLE_WARNINGS_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_DISABLE_WARNINGS_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-w")
