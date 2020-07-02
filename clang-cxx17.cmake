# Copyright (c) 2016-2018, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_CLANG_CXX17_CMAKE_)
  return()
else()
  set(POLLY_CLANG_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang / c++17 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")

if (CMAKE_HOST_APPLE)
  # Needed for boost to actually build  
  execute_process (
    COMMAND bash -c "xcrun --sdk macosx --show-sdk-path"
    OUTPUT_VARIABLE SDKROOT_PATH
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  set(ENV{SDKROOT} "${SDKROOT_PATH}")
  set(CMAKE_SYSROOT "${SDKROOT_PATH}" CACHE PATH "")
endif()
