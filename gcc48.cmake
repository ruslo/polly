# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC48_CMAKE)
  return()
else()
  set(POLLY_GCC48_CMAKE 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "gcc 4.8 / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "gcc48")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc48.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
