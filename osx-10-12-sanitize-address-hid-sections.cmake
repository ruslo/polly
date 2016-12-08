# Copyright (c) 2016, Ruslan Baratov
# Copyright (c) 2016, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_OSX_10_12_SANITIZE_ADDRESS_HID_SECTIONS_CMAKE_)
  return()
else()
  set(POLLY_OSX_10_12_SANITIZE_ADDRESS_HID_SECTIONS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(OSX_SDK_VERSION "10.12")
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "Xcode (OS X ${OSX_SDK_VERSION}) / \
${POLLY_XCODE_COMPILER} / \
LLVM Standard C++ Library (libc++) / Clang address sanitizer / c++11 support / hidden / function-sections / data-sections "
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.12" CACHE STRING "OS X Deployment target" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_address.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
