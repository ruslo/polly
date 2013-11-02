# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

set(POLLY_TOOLCHAIN_NAME "libstdc++")
set(POLLY_TOOLCHAIN_PREFIX "libstdcxx")

include("${CMAKE_CURRENT_LIST_DIR}/Common.cmake")

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libstdc++"
    CACHE
    STRING
    "C++ compiler flags"
)
