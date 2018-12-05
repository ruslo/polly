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
    __osx_sysroot_suggestion_1
    "${XCODE_DEVELOPER_ROOT}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${OSX_SDK_VERSION}.sdk"
)

# With a full Xcode install, typically `xcode-select -print-path` is something like:
#     /Applications/Xcode.app/Contents/Developer
#
# But with just Xcode command line tools installed, the path is:
#     /Library/Developer/CommandLineTools
#
# In the CommandLineTools case, the SDKs folder is at a different relative path.
set(
    __osx_sysroot_suggestion_2
    "${XCODE_DEVELOPER_ROOT}/SDKs/MacOSX${OSX_SDK_VERSION}.sdk"
)

if(EXISTS "${__osx_sysroot_suggestion_1}")
  set(__osx_sysroot "${__osx_sysroot_suggestion_1}")
elseif(EXISTS "${__osx_sysroot_suggestion_2}")
  set(__osx_sysroot "${__osx_sysroot_suggestion_2}")
else()
  # If OSX_SDK_VERSION is not set, the SDK version is computed using
  # xcrun. However, it is possible for the version reported by xcrun to not
  # be present in the SDKs folder. In that case, xcrun can also give the
  # full path to a valid SDK.
  execute_process(
      COMMAND xcrun --show-sdk-path
      RESULT_VARIABLE _result
      OUTPUT_VARIABLE __osx_sysroot_suggestion_3
      OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  if(NOT _result EQUAL 0)
    polly_fatal_error("'xcrun --show-sdk-path' failed")
  endif()

  if(EXISTS "${__osx_sysroot_suggestion_3}")
    set(__osx_sysroot "${__osx_sysroot_suggestion_3}")
  else()
    polly_fatal_error("OS X SDK does not exist at ${__osx_sysroot_suggestion_1} or ${__osx_sysroot_suggestion_2} or ${__osx_sysroot_suggestion_3}")
  endif()
endif()

set(
    CMAKE_OSX_SYSROOT
    "${__osx_sysroot}"
    CACHE STRING "System root for OSX" FORCE
)
