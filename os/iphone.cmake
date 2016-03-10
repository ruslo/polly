# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_IPHONE_CMAKE)
  return()
else()
  set(POLLY_OS_IPHONE_CMAKE 1)
endif()

set(CMAKE_OSX_SYSROOT "iphoneos" CACHE STRING "System root for iOS" FORCE)
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator")

# find 'iphoneos' and 'iphonesimulator' roots and version
find_program(XCODE_SELECT_EXECUTABLE xcode-select)
if(NOT XCODE_SELECT_EXECUTABLE)
  polly_fatal_error("xcode-select not found")
endif()

if(XCODE_VERSION VERSION_LESS "5.0.0")
  polly_fatal_error("Works since Xcode 5.0.0 (current ver: ${XCODE_VERSION})")
endif()

if(CMAKE_VERSION VERSION_LESS "3.5")
  polly_fatal_error(
      "CMake minimum required version for iOS is 3.5 (current ver: ${CMAKE_VERSION})"
  )
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

find_program(XCODEBUILD_EXECUTABLE xcodebuild)
if(NOT XCODEBUILD_EXECUTABLE)
  polly_fatal_error("xcodebuild not found")
endif()

# Check version exists
execute_process(
    COMMAND
    "${XCODEBUILD_EXECUTABLE}"
    -showsdks
    -sdk
    "iphoneos${IOS_SDK_VERSION}"
    RESULT_VARIABLE
    IOS_SDK_VERSION_RESULT
    OUTPUT_QUIET
    ERROR_QUIET
)
if(NOT "${IOS_SDK_VERSION_RESULT}" EQUAL 0)
  polly_fatal_error("iOS version `${IOS_SDK_VERSION}` not found (${IOS_SDK_VERSION_RESULT})")
endif()

# iPhone simulator root
set(
    IPHONESIMULATOR_ROOT
    "${XCODE_DEVELOPER_ROOT}/Platforms/iPhoneSimulator.platform/Developer"
)
if(NOT EXISTS "${IPHONESIMULATOR_ROOT}")
  polly_fatal_error(
      "IPHONESIMULATOR_ROOT not found (${IPHONESIMULATOR_ROOT})\n"
      "XCODE_DEVELOPER_ROOT: ${XCODE_DEVELOPER_ROOT}\n"
  )
endif()

# iPhone simulator SDK root
set(
    IPHONESIMULATOR_SDK_ROOT
    "${IPHONESIMULATOR_ROOT}/SDKs/iPhoneSimulator${IOS_SDK_VERSION}.sdk"
)

if(NOT EXISTS ${IPHONESIMULATOR_SDK_ROOT})
  polly_fatal_error(
      "IPHONESIMULATOR_SDK_ROOT not found (${IPHONESIMULATOR_SDK_ROOT})\n"
      "IPHONESIMULATOR_ROOT: ${IPHONESIMULATOR_ROOT}\n"
      "IOS_SDK_VERSION: ${IOS_SDK_VERSION}\n"
  )
endif()

# iPhone root
set(
    IPHONEOS_ROOT
    "${XCODE_DEVELOPER_ROOT}/Platforms/iPhoneOS.platform/Developer"
)
if(NOT EXISTS "${IPHONEOS_ROOT}")
  polly_fatal_error(
      "IPHONEOS_ROOT not found (${IPHONEOS_ROOT})\n"
      "XCODE_DEVELOPER_ROOT: ${XCODE_DEVELOPER_ROOT}\n"
  )
endif()

# iPhone SDK root
set(IPHONEOS_SDK_ROOT "${IPHONEOS_ROOT}/SDKs/iPhoneOS${IOS_SDK_VERSION}.sdk")

if(NOT EXISTS ${IPHONEOS_SDK_ROOT})
  hunter_fatal_error(
      "IPHONEOS_SDK_ROOT not found (${IPHONEOS_SDK_ROOT})\n"
      "IPHONEOS_ROOT: ${IPHONEOS_ROOT}\n"
      "IOS_SDK_VERSION: ${IOS_SDK_VERSION}\n"
  )
endif()

string(COMPARE EQUAL "${IOS_DEPLOYMENT_SDK_VERSION}" "" _is_empty)
if(_is_empty)
  set(
      CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET
      "${IOS_SDK_VERSION}"
  )
else()
  set(
      CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET
      "${IOS_DEPLOYMENT_SDK_VERSION}"
  )
endif()

# Emulate OpenCV toolchain --
set(IOS YES)
# -- end

# Set iPhoneOS architectures
set(archs "")
foreach(arch ${IPHONEOS_ARCHS})
  set(archs "${archs} ${arch}")
endforeach()
set(CMAKE_XCODE_ATTRIBUTE_ARCHS[sdk=iphoneos*] "${archs}")
set(CMAKE_XCODE_ATTRIBUTE_VALID_ARCHS[sdk=iphoneos*] "${archs}")

# Set iPhoneSimulator architectures
set(archs "")
foreach(arch ${IPHONESIMULATOR_ARCHS})
  set(archs "${archs} ${arch}")
endforeach()
set(CMAKE_XCODE_ATTRIBUTE_ARCHS[sdk=iphonesimulator*] "${archs}")
set(CMAKE_XCODE_ATTRIBUTE_VALID_ARCHS[sdk=iphonesimulator*] "${archs}")

# Introduced in iOS 9.0
set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE NO)
