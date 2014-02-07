# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_IPHONE_CMAKE)
  return()
else()
  set(POLLY_OS_IPHONE_CMAKE 1)
endif()

if(NOT XCODE_VERSION)
  polly_fatal_error("This toolchain is available only on Xcode")
endif()

set(CMAKE_OSX_SYSROOT "iphoneos" CACHE STRING "System root for iOS" FORCE)
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator")

# find 'iphoneos' and 'iphonesimulator' roots and version
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
)

find_program(XCODEBUILD_EXECUTABLE xcodebuild)
if(NOT XCODEBUILD_EXECUTABLE)
  polly_fatal_error("xcodebuild not found")
endif()

# Order is important(!)
# Set high priority to the last
set(IOS_SDK_VERSIONS 5.0 5.1 6.0 6.1 7.0)
foreach(x ${IOS_SDK_VERSIONS})
  execute_process(
      COMMAND
      "${XCODEBUILD_EXECUTABLE}"
      -showsdks
      -sdk
      "iphoneos${x}"
      RESULT_VARIABLE
      IOS_SDK_VERSION_RESULT
      OUTPUT_QUIET
      ERROR_QUIET
  )
  if(${IOS_SDK_VERSION_RESULT} EQUAL 0)
    set(IOS_SDK_VERSION ${x})
  endif()
endforeach()

if(NOT IOS_SDK_VERSION)
  polly_fatal_error("iOS version not found, tested: [${IOS_SDK_VERSIONS}]")
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
