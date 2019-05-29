# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_DEP_8_0_ARM64_CXX11_CMAKE)
  return()
else()
  set(POLLY_IOS_DEP_8_0_ARM64_CXX11_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_module_path.cmake")
include(polly_clear_environment_variables)
include(polly_init)
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone-default-sdk.cmake") # -> IOS_SDK_VERSION

set(IOS_DEPLOYMENT_SDK_VERSION 8.0)
set(POLLY_XCODE_COMPILER "clang")
polly_init(
  "iOS ${IOS_SDK_VERSION} / Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / arm64 / \
${POLLY_XCODE_COMPILER} / \
c++11 support "
  "Xcode"
)

include(polly_common)
include(polly_fatal_error)

# Fix try_compile
include(polly_ios_bundle_identifier)

set(CMAKE_MACOSX_BUNDLE YES)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

set(IPHONEOS_ARCHS arm64)
set(IPHONESIMULATOR_ARCHS "")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
if(NOT IOS_SDK_VERSION VERSION_LESS 10.0) 
  include(polly_ios_development_team) 
endif()
