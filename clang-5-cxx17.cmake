# Copyright (c) 2016-2017, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_CLANG_5_CXX17_CMAKE_)
  return()
else()
  set(POLLY_CLANG_5_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang 5 / c++17 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang-5.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
