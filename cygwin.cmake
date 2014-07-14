# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CYGWIN_CMAKE_)
  return()
else()
  set(POLLY_CYGWIN_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "cygwin / gcc / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/cygwin.cmake")
