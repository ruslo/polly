# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_CYGWIN_CMAKE_)
  return()
else()
  set(POLLY_OS_CYGWIN_CMAKE_ 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -U__STRICT_ANSI__"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)
