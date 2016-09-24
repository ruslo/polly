# Copyright (c) 2016
# All rights reserved.

if(DEFINED POLLY_VS_14_2015_ARM_CMAKE_)
  return()
else()
  set(POLLY_VS_14_2015_ARM_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Visual Studio 14 2015 ARM"
    "Visual Studio 14 2015 ARM"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
