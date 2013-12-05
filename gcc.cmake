# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_CMAKE)
  return()
else()
  set(POLLY_GCC_CMAKE 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "gcc / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "gcc")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
