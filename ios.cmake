# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_CMAKE_)
return()
else()
set(POLLY_IOS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone-default-sdk.cmake")

set(POLLY_XCODE_COMPILER "clang")
polly_init(
  "iOS ${IOS_SDK_VERSION} Universal (iphoneos + iphonesimulator) / \
${POLLY_XCODE_COMPILER} / \
c++14 support"
  "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# # Fix try_compile
include(polly_ios_bundle_identifier)
set(CMAKE_MACOSX_BUNDLE YES)

set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

# 32 bits support was dropped from iPhoneSdk11.0
if  ( (${IOS_SDK_VERSION} STRGREATER "11.0" ) OR (${IOS_SDK_VERSION} STREQUAL "11.0"))
  polly_status_debug("iPhone11.0+ SDK detected, forcing 64 bits builds.")
  set(IPHONEOS_ARCHS arm64)
  set(IPHONESIMULATOR_ARCHS x86_64)
else()
  set(IPHONEOS_ARCHS armv7;armv7s;arm64)
  set(IPHONESIMULATOR_ARCHS i386;x86_64)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_ios_development_team.cmake")
