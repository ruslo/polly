# Copyright (c) 2013-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_32BIT_PIC_CMAKE_)
  return()
else()
  set(POLLY_GCC_32BIT_PIC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / PIC / c++11 support / 32 bit"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/32bit.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
