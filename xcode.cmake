# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_XCODE_CMAKE_)
  return()
else()
  set(POLLY_XCODE_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "Xcode / ${POLLY_XCODE_COMPILER} / \
LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
