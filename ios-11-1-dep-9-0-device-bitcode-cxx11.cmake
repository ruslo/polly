# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_11_1_DEP_9_0_DEVICE_BITCODE_CMAKE_)
  return()
else()
  set(POLLY_IOS_11_1_DEP_9_0_DEVICE_BITCODE_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 11.1)
set(IOS_DEPLOYMENT_SDK_VERSION 9.0)

set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} / Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / Universal (arm64 armv7s armv7) / \
${POLLY_XCODE_COMPILER} / \
bitcode / \
c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
include(polly_ios_bundle_identifier)

set(CMAKE_MACOSX_BUNDLE YES)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

set(IPHONEOS_ARCHS armv7;armv7s;arm64)
set(IPHONESIMULATOR_ARCHS "")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/bitcode.cmake") # after os/iphone.cmake

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_ios_development_team.cmake")
