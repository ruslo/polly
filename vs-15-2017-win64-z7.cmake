# Copyright (c) 2015-2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_15_2017_WIN64_Z7_CMAKE_)
  return()
else()
  set(POLLY_VS_15_2017_WIN64_Z7_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 15 2017 Win64"
    "Visual Studio 15 2017 Win64"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/vs-z7.cmake")
