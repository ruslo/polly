# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_MINGW_CMAKE_)
  return()
else()
  set(POLLY_MINGW_CMAKE_ 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "mingw / gcc / c++11 support"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

set(HUNTER_CMAKE_GENERATOR "MinGW Makefiles")
