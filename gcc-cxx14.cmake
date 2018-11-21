# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_GCC_CXX14_CMAKE)
  return()
else()
  set(POLLY_GCC_CXX14_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "gcc / c++14 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
