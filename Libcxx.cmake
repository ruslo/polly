# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBCXX_CMAKE)
  return()
else()
  set(POLLY_LIBCXX_CMAKE 1)
endif()

set(POLLY_TOOLCHAIN_NAME "LLVM Standard C++ Library (libc++)")
set(POLLY_TOOLCHAIN_TAG "libcxx")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/common.cmake")

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++"
    CACHE
    STRING
    "C++ compiler flags"
)
