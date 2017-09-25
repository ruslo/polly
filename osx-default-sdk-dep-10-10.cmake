# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OSX_DEFAULT_SDK_DEP_10_10_)
  return()
else()
  set(POLLY_OSX_DEFAULT_SDK_DEP_10_10_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(OSX_SDK_VERSION "10.10")
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "Xcode (OS X ${OSX_SDK_VERSION} | Deployment 10.7) / \
${POLLY_XCODE_COMPILER} / \
LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")

set(CMAKE_OSX_DEPLOYMENT_TARGET "10.7" CACHE STRING "OS X Deployment target" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

# adapted from os/osx.cmake
if(DEFINED POLLY_OS_OSX_CMAKE_)
  return()
else()
  set(POLLY_OS_OSX_CMAKE_ 1)
endif()

# Toolchain can be loaded from Linux too (e.g. by libcxx or gcc)
if(NOT APPLE)
  return()
endif()

if(IOS)
  polly_fatal_error("Not for iOS")
endif()

# find 'osx' root
find_program(XCODE_SELECT_EXECUTABLE xcode-select)
if(NOT XCODE_SELECT_EXECUTABLE)
  polly_fatal_error("xcode-select not found")
endif()

string(COMPARE EQUAL "$ENV{DEVELOPER_DIR}" "" _is_empty)
if(NOT _is_empty)
  polly_status_debug("Developer root (env): $ENV{DEVELOPER_DIR}")
endif()

execute_process(
    COMMAND
    ${XCODE_SELECT_EXECUTABLE}
    "-print-path"
    OUTPUT_VARIABLE
    XCODE_DEVELOPER_ROOT # /.../Xcode.app/Contents/Developer
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

polly_status_debug("Developer root: ${XCODE_DEVELOPER_ROOT}")

set(
    CMAKE_OSX_SYSROOT
    "${XCODE_DEVELOPER_ROOT}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
    CACHE STRING "System root for OSX" FORCE
)

if(NOT EXISTS "${CMAKE_OSX_SYSROOT}")
  polly_fatal_error("${CMAKE_OSX_SYSROOT} not exists")
endif()
