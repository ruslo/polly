# Copyright (c) 2013-2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_IOS_8_2_I386_ARM64_CMAKE_)
  return()
else()
  set(POLLY_IOS_8_2_I386_ARM64_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "iOS 8.2 Universal (iphoneos + iphonesimulator) / i386 / arm64 / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_fatal_error)

# Fix try_compile
set(MACOSX_BUNDLE_GUI_IDENTIFIER com.example)
set(CMAKE_MACOSX_BUNDLE YES)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

set(IPHONEOS_ARCHS arm64)
set(IPHONESIMULATOR_ARCHS i386)
set(IOS_SDK_VERSION 8.2)

include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
