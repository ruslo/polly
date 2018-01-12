# Copyright (c) 2013-2017, Ruslan Baratov
# Copyright (c) 2017, Richard Hodges
# All rights reserved.

if(DEFINED POLLY_CXX14_CMAKE_)
    return()
else()
    set(POLLY_CXX14_CMAKE_ 1)
endif()

# Don't use polly_init (no generator expected)
set(POLLY_TOOLCHAIN_NAME "C++14 support")
set(POLLY_TOOLCHAIN_TAG "cxx14")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

set(CMAKE_CXX_STANDARD 14)
