# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_NMAKE_VS2013_CMAKE_)
  return()
else()
  set(POLLY_NMAKE_VS2013_CMAKE_ 1)
endif()

set(POLLY_TOOLCHAIN_NAME "NMake / Visual Studio 2013 / x86")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/msvc-2013.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/arch/msvc-x86.cmake")

set(HUNTER_CMAKE_GENERATOR "NMake Makefiles")
