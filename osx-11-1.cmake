# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OSX_11_1_CMAKE_)
  return()
else()
  set(POLLY_OSX_11_1_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(OSX_SDK_VERSION "11.1")
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "Xcode (OS X ${OSX_SDK_VERSION}) / \
${POLLY_XCODE_COMPILER} / \
LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")

set(CMAKE_OSX_DEPLOYMENT_TARGET "11.1" CACHE STRING "OS X Deployment target" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
