# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_VS_8_2005_CMAKE_)
  return()
else()
  set(POLLY_VS_8_2005_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 8 2005"
    "Visual Studio 8 2005"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
