# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_THREAD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_THREAD_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize=thread")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-fPIE")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-pie")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-g")

polly_add_cache_flag(CMAKE_C_FLAGS "-fsanitize=thread")
polly_add_cache_flag(CMAKE_C_FLAGS "-fPIE")
polly_add_cache_flag(CMAKE_C_FLAGS "-pie")
polly_add_cache_flag(CMAKE_C_FLAGS "-g")
