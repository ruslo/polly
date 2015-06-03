# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_XCODE_CMAKE_)
  return()
else()
  set(POLLY_XCODE_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Xcode / LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

# There is no way to change compiler for Xcode generator so there is no sense
# to set CMAKE_C_COMPILER/CMAKE_CXX_COMPILER variables here. If you know
# how to change default compiler that Xcode use please let me know :)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
