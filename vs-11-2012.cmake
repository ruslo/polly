# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_11_2012_CMAKE_)
  return()
else()
  set(POLLY_VS_11_2012_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 11 2012"
    "Visual Studio 11 2012"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/msvc-2012.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/arch/msvc-x86.cmake")
