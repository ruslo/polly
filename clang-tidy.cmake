# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG_TIDY_CMAKE_)
  return()
else()
  set(POLLY_CLANG_TIDY_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang tidy / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/clang-tidy.cmake")
