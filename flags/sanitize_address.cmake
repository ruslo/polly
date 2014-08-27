# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_ 1)
endif()

include(polly_add_cache_flag)
polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize=address")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-g")

set(
    CMAKE_CXX_FLAGS_RELEASE
    "-O1"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
