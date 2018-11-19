# Copyright (c) 2016-2018, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_GCC_7_CXX17_GNU_CMAKE_)
  return()
else()
  set(POLLY_GCC_7_CXX17_GNU_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc 7 / c++17 support / GNU"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-7.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17-gnu.cmake")
