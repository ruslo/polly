# Copyright (c) 2015, Ruslan Baratov & Michele Caini
# All rights reserved.

if(DEFINED POLLY_IOS_NOCODESIGN_9_2_ARM64_CMAKE)
  return()
else()
  set(POLLY_IOS_NOCODESIGN_9_2_ARM64_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 9.2)
set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} arm64 (iphoneos + iphonesimulator) / \
${POLLY_XCODE_COMPILER} / \
No code sign / \
c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
set(MACOSX_BUNDLE_GUI_IDENTIFIER com.example)
set(CMAKE_MACOSX_BUNDLE YES)

# Verify XCODE_XCCONFIG_FILE
set(
    _polly_xcode_xcconfig_file_path
    "${CMAKE_CURRENT_LIST_DIR}/scripts/NoCodeSign.xcconfig"
)
if(NOT EXISTS "$ENV{XCODE_XCCONFIG_FILE}")
  polly_fatal_error(
      "Path specified by XCODE_XCCONFIG_FILE environment variable not found"
      "($ENV{XCODE_XCCONFIG_FILE})"
      "Use this command to set: "
      "    export XCODE_XCCONFIG_FILE=${_polly_xcode_xcconfig_file_path}"
  )
else()
  string(
      COMPARE
      NOTEQUAL
      "$ENV{XCODE_XCCONFIG_FILE}"
      "${_polly_xcode_xcconfig_file_path}"
      _polly_wrong_xcconfig_path
  )
  if(_polly_wrong_xcconfig_path)
    polly_fatal_error(
        "Unexpected XCODE_XCCONFIG_FILE value: "
        "    $ENV{XCODE_XCCONFIG_FILE}"
        "expected: "
        "    ${_polly_xcode_xcconfig_file_path}"
    )
  endif()
endif()

set(IPHONEOS_ARCHS arm64)
set(IPHONESIMULATOR_ARCHS "")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
