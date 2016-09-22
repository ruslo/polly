# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_14_2015_WIN64_SDK_8_1_CMAKE_)
  return()
else()
  set(POLLY_VS_14_2015_WIN64_SDK_8_1_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 14 2015 Win64 | SDK 8.1"
    "Visual Studio 14 2015 Win64"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

set(CMAKE_SYSTEM_VERSION 8.1)
