# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_C_CXX_X86_CMAKE)
  return()
else()
  set(POLLY_FLAGS_C_CXX_X86_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-m32 -march=native")
polly_add_cache_flag(CMAKE_C_FLAGS "-m32 -march=native")
