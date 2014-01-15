# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_LEAK_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_LEAK_CMAKE_ 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -fsanitize=leak -g"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
