# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_ 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -fsanitize=address -g"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)

set(
    CMAKE_CXX_FLAGS_RELEASE
    "-O1"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
