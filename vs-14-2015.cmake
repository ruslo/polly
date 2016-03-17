# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_14_2015_CMAKE_)
  return()
else()
  set(POLLY_VS_14_2015_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 14 2015"
    "Visual Studio 14 2015"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
