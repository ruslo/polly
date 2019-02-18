# Copyright (c) 2013, 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_NINJA_CMAKE_)
  return()
else()
  set(POLLY_GCC_NINJA_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / c++11 support"
    "Ninja"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
