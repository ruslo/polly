# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_GCOV_CMAKE_)
  return()
else()
  set(POLLY_GCC_GCOV_CMAKE_ 1)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE YES)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / PIC / gcov / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/gcov.cmake")