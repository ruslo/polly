# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_CXX98_CMAKE)
  return()
else()
  set(POLLY_GCC_CXX98_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx98.cmake")
