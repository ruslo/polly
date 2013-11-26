# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBSTDCXX_CMAKE)
  return()
else()
  set(POLLY_LIBSTDCXX_CMAKE 1)
endif()

set(POLLY_TOOLCHAIN_NAME "GNU Standard C++ Library (libstdc++)")
set(POLLY_TOOLCHAIN_TAG "libstdcxx")

include("${CMAKE_CURRENT_LIST_DIR}/Common.cmake")

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libstdc++"
    CACHE
    STRING
    "C++ compiler flags"
)
