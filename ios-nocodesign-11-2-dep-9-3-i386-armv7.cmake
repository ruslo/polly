# Copyright (c) 2017-2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_NOCODESIGN_11_2_DEP_9_3_I386_ARMV7_CMAKE_)
  return()
else()
  set(POLLY_IOS_NOCODESIGN_11_2_DEP_9_3_I386_ARMV7_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(IOS_SDK_VERSION 11.2)
set(IOS_DEPLOYMENT_SDK_VERSION 9.3)

set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} / Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / \
${POLLY_XCODE_COMPILER} / \
i386 / armv7 / \
No code sign / \
c++14 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
include(polly_ios_bundle_identifier)

set(CMAKE_MACOSX_BUNDLE YES)

include("${CMAKE_CURRENT_LIST_DIR}/flags/ios_nocodesign.cmake")

set(IPHONEOS_ARCHS armv7)
set(IPHONESIMULATOR_ARCHS i386)

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
