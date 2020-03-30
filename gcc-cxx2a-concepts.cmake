# Copyright (c) 2016-2017, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# Copyright (c) 2020, Richard Hodges (hodges.r@gmail.com)
# All rights reserved.

if(DEFINED POLLY_GCC_CXX2a_CONCEPTS_CMAKE_)
  return()
else()
  set(POLLY_GCC_CXX2a_CONCEPTS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / c++2a support / concepts"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx2a.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/fconcepts.cmake")
