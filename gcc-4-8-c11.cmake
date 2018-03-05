# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC48_C11_CMAKE_)
  return()
else()
  set(POLLY_GCC48_C11_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc 4.8 / c++11 support / C11"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc48.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/c11.cmake")
