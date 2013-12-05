# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX11_CMAKE)
  return()
else()
  set(POLLY_FLAGS_CXX11_CMAKE 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
