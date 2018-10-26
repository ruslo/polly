# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_MINGW_CXX17_CMAKE_)
  return()
else()
  set(POLLY_MINGW_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "mingw / gcc / c++17 support"
    "MinGW Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
