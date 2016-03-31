# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

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

string(COMPARE EQUAL "${OSX_SDK_VERSION}" "" _is_empty)
if(_is_empty)
  execute_process(
      COMMAND xcrun --show-sdk-version
      RESULT_VARIABLE _result
      OUTPUT_VARIABLE OSX_SDK_VERSION
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  if(NOT _result EQUAL 0)
    polly_fatal_error("'xcrun --show-sdk-version' failed")
  endif()
endif()

set(
    CMAKE_OSX_SYSROOT
    "${XCODE_DEVELOPER_ROOT}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${OSX_SDK_VERSION}.sdk"
    CACHE STRING "System root for OSX" FORCE
)

if(NOT EXISTS "${CMAKE_OSX_SYSROOT}")
  polly_fatal_error("${CMAKE_OSX_SYSROOT} not exists")
endif()
