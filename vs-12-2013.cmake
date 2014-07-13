# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_12_2013_CMAKE_)
  return()
else()
  set(POLLY_VS_12_2013_CMAKE_ 1)
endif()

set(POLLY_TOOLCHAIN_NAME "Visual Studio 12 2013")
set(POLLY_TOOLCHAIN_TAG "vs-12-2013")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/msvc-2013.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/arch/msvc-x86.cmake")
