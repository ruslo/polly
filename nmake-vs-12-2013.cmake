# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_NMAKE_VS_12_2013_CMAKE_)
  return()
else()
  set(POLLY_NMAKE_VS_12_2013_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "NMake / Visual Studio 2013 / x86"
    "NMake Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
