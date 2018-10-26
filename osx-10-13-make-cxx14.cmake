# Copyright (c) 2016, 2018 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OSX_10_13_MAKE_CXX14_CMAKE_)
  return()
else()
  set(POLLY_OSX_10_13_MAKE_CXX14_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(OSX_SDK_VERSION "10.13")
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "Makefile (OS X ${OSX_SDK_VERSION}) / \
${POLLY_XCODE_COMPILER} / \
LLVM Standard C++ Library (libc++) / c++14 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.13" CACHE STRING "OS X Deployment target" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
