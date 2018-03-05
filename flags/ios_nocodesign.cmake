# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_IOS_NOCODESIGN_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_IOS_NOCODESIGN_CMAKE_ 1)
endif()

# Verify XCODE_XCCONFIG_FILE
set(
    _polly_xcode_xcconfig_file_path
    "${CMAKE_CURRENT_LIST_DIR}/../scripts/NoCodeSign.xcconfig"
)
get_filename_component(
    _polly_xcode_xcconfig_file_path
    "${_polly_xcode_xcconfig_file_path}"
    ABSOLUTE
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
