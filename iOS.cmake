# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_CMAKE)
  return()
else()
  set(POLLY_IOS_CMAKE 1)
endif()

set(POLLY_TOOLCHAIN_NAME "iOS")
set(POLLY_TOOLCHAIN_PREFIX "ios")

include("${CMAKE_CURRENT_LIST_DIR}/Common.cmake")

if(NOT XCODE_VERSION)
  message(FATAL_ERROR "This toolchain is available only on Xcode")
endif()

set(CMAKE_OSX_SYSROOT "iphoneos" CACHE STRING "System root for iOS")

# Skip compiler check:
#     http://cmake.org/Bug/view.php?id=12288
#     http://code.google.com/p/ios-cmake/issues/detail?id=1
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_C_COMPILER_WORKS TRUE)
