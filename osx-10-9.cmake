# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OSX_10_9_CMAKE_)
  return()
else()
  set(POLLY_OSX_10_9_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Xcode (OS X 10.9) / LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

# There is no way to change compiler for Xcode generator so there is no sense
# to set CMAKE_C_COMPILER/CMAKE_CXX_COMPILER variables here. If you know
# how to change default compiler that Xcode use please let me know :)

set(OSX_SDK_VERSION "10.9")
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "OS X Deployment target" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
