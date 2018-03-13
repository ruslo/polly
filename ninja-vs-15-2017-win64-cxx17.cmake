# Copyright (c) 2016, 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_NINJA_VS_15_2017_WIN64_CXX17_CMAKE_)
  return()
else()
  set(POLLY_NINJA_VS_15_2017_WIN64_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Ninja / Visual Studio 2017 / x64 / C++17"
    "Ninja"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/cl.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/vs-cxx17.cmake")
