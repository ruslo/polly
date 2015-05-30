# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R10E_API_8_ARMEABI_V7A_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R10E_API_8_ARMEABI_V7A_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r10e")
set(ANDROID_NATIVE_API_LEVEL "8")
set(ANDROID_ABI "armeabi-v7a")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${ANDROID_NATIVE_API_LEVEL} / ${ANDROID_ABI} / \
c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
