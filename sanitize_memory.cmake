# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_SANITIZE_MEMORY_CMAKE_)
  return()
else()
  set(POLLY_SANITIZE_MEMORY_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang memory sanitizer / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_memory.cmake")
