# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_NMAKE_VS2013_X64_CMAKE_)
  return()
else()
  set(POLLY_NMAKE_VS2013_X64_CMAKE_ 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "NMake / Visual Studio 2013 / x64"
)
set(POLLY_TOOLCHAIN_TAG "nmake-vs2013-x64")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
