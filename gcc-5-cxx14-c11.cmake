# Copyright (c) 2013-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_5_CXX14_C11_CMAKE_)
  return()
else()
  set(POLLY_GCC_5_CXX14_C11_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc 5 / c++14 support / C11"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-5.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/c11.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")

