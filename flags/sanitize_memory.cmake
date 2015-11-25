# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_MEMORY_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_MEMORY_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize=memory")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize-memory-track-origins")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-g")

polly_add_cache_flag(CMAKE_C_FLAGS "-fsanitize=memory")
polly_add_cache_flag(CMAKE_C_FLAGS "-fsanitize-memory-track-origins")
polly_add_cache_flag(CMAKE_C_FLAGS "-g")
