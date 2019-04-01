# Copyright (c) 2016-2019, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_CLANG_CXX17_PIC_CMAKE_)
  return()
else()
  set(POLLY_CLANG_CXX17_PIC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang / c++17 support / PIC"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
