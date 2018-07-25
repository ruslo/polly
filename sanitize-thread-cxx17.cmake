# Copyright (c) 2014, 2018 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_SANITIZE_THREAD_CXX17_CMAKE_)
  return()
else()
  set(POLLY_SANITIZE_THREAD_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang thread sanitizer / c++17 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_thread.cmake")
