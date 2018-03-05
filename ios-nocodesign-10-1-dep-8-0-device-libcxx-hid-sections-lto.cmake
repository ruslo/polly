# Copyright (c) 2015, Tomas Zemaitis
# Copyright (c) 2016, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_IOS_NOCODESIGN_10_1_DEP_8_0_DEVICE_LIBCXX_HID_SECTIONS_LTO_CMAKE_)
  return()
else()
  set(POLLY_IOS_NOCODESIGN_10_1_DEP_8_0_DEVICE_LIBCXX_HID_SECTIONS_LTO_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 10.1)
set(IOS_DEPLOYMENT_SDK_VERSION 8.0)
set(POLLY_XCODE_COMPILER "clang")

polly_init(
    "iOS ${IOS_SDK_VERSION} / Universal (arm64 armv7s armv7) / \
Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / \
${POLLY_XCODE_COMPILER} / \
No code sign / \
c++11 support / hidden / data-sections / function-sections / LTO"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
include(polly_ios_bundle_identifier)
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

set(IPHONEOS_ARCHS armv7;armv7s;arm64)
set(IPHONESIMULATOR_ARCHS "")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/lto.cmake")
