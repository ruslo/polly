# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_GCOV_CMAKE)
  return()
else()
  set(POLLY_FLAGS_GCOV_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fprofile-arcs -ftest-coverage -O0")
