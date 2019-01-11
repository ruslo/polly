# Copyright (c) 2016-2017, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

# based on original gcc-7-cxx14-pic.cmake but assumes gcc itself is gcc v7

if(DEFINED POLLY_GCC_CXX14_PIC_CMAKE_)
  return()
else()
  set(POLLY_GCC_CXX14_PIC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / c++14 support / PIC"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11-abi-disable.cmake") # effectively forced to 0 on RH7 and centos7, so disable to be consistent
include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
