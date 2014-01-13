# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_SANITIZE_MEMORY_CMAKE_)
  return()
else()
  set(POLLY_SANITIZE_MEMORY_CMAKE_ 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "Clang memory sanitizer / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "sanitize_memory")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_memory.cmake")

set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_C_COMPILER clang)
