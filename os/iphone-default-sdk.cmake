# This script sets the following variables :
# IOS_SDK_VERSION : will contain the version number of the default iOS SDK (example : 11.0)
# IPHONEOS_SDK_ROOT : full path to the SDK
# IPHONEOS_ROOT
# XCODE_DEVELOPER_ROOT

if(DEFINED POLLY_IPHONE_DEFAULT_SDK_CMAKE)
  return()
else()
  set(POLLY_IPHONE_DEFAULT_SDK_CMAKE 1)
endif()

include(polly_status_debug)

# polly_find_xcode_ios_defaults : 
# fills 
# * XCODE_DEVELOPER_ROOT
# * IPHONEOS_ROOT 
# * IPHONEOS_SDK_ROOT
macro (polly_find_xcode_ios_defaults)
  find_program(XCODE_SELECT_EXECUTABLE xcode-select)
  if(NOT XCODE_SELECT_EXECUTABLE)
    polly_fatal_error("xcode-select not found")
  endif()
  execute_process(
    COMMAND
    ${XCODE_SELECT_EXECUTABLE}
    "-print-path"
    OUTPUT_VARIABLE 
      XCODE_DEVELOPER_ROOT # /.../Xcode.app/Contents/Developer
    OUTPUT_STRIP_TRAILING_WHITESPACE
    RESULT_VARIABLE
      _XCODE_DEVELOPER_ROOT_STATUS
  )
  if(NOT "${_XCODE_DEVELOPER_ROOT_STATUS}" EQUAL "0")
    polly_fatal_error("Could not find XCODE_DEVELOPER_ROOT.
      The command
      ${XCODE_SELECT_EXECUTABLE} -print-path
      failed with the following status : ${_XCODE_DEVELOPER_ROOT_STATUS}
      ")
  endif()

  set(IPHONEOS_ROOT "${XCODE_DEVELOPER_ROOT}/Platforms/iPhoneOS.platform/Developer")
  # The defautl SDK is at ${IPHONEOS_ROOT}/SDKs/iPhoneOS.sdk
  set(IPHONEOS_SDK_ROOT "${IPHONEOS_ROOT}/SDKs/iPhoneOS.sdk")
  polly_status_debug("XCODE_DEVELOPER_ROOT=${XCODE_DEVELOPER_ROOT}")
  polly_status_debug("IPHONEOS_ROOT=${IPHONEOS_ROOT}")
  polly_status_debug("IPHONEOS_SDK_ROOT=${IPHONEOS_SDK_ROOT}")
endmacro()

polly_find_xcode_ios_defaults()

# The version number of the SDK can be accessed by reading the SDKSettings.plist file with the command :
#   defaults read ${IPHONEOS_SDK_ROOT}/SDKSettings.plist DefaultDeploymentTarget
execute_process(
  COMMAND
  "defaults"
  read
  ${IPHONEOS_SDK_ROOT}/SDKSettings.plist
  DefaultDeploymentTarget
  RESULT_VARIABLE _POLLY_PROCESS_RESULT
  OUTPUT_VARIABLE IOS_SDK_VERSION
  OUTPUT_STRIP_TRAILING_WHITESPACE
  ERROR_STRIP_TRAILING_WHITESPACE
)
if(NOT "${_POLLY_PROCESS_RESULT}" EQUAL "0")
  polly_fatal_error("Could not read the iPhoneSDK version ().
    The command
    defaults read ${IPHONEOS_SDK_ROOT}/SDKSettings.plist DefaultDeploymentTarget
    failed with the following status : ${_POLLY_PROCESS_RESULT}
    ")
endif()
polly_status_debug("IOS_SDK_VERSION=${IOS_SDK_VERSION}")
