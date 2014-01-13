# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_THREAD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_THREAD_CMAKE_ 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -fsanitize=thread -fPIE -pie -g"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
