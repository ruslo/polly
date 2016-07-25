# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_ANDROID_VC_NDK_R10E_API_19_ARM_CLANG_3_6_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_VC_NDK_R10E_API_19_ARM_CLANG_3_6_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r10e") # default, variable not used
set(ANDROID_NATIVE_API_LEVEL "19")
set(ANDROID_TOOLCHAIN_NAME "Clang_3_6")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${ANDROID_NATIVE_API_LEVEL} / ARM / ${ANDROID_TOOLCHAIN_NAME} / \
c++11 support"
    "Visual Studio 14 2015 ARM"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/os/vc-mdd-android.cmake")
