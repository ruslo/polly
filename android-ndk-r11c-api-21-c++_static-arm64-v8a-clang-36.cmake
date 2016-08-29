# Copyright (c) 2016, Michele Caini
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R11C_API_21_CPP_STATIC_ARM64_V8A_CLANG_36_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R11C_API_21_CPP_STATIC_ARM64_V8A_CLANG_36_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r11c")
set(ANDROID_NATIVE_API_LEVEL "21")
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_TOOLCHAIN_NAME "aarch64-linux-android-clang3.6")
set(ANDROID_STL "c++_static")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${ANDROID_NATIVE_API_LEVEL} / ${ANDROID_ABI} / ${ANDROID_STL} / ${ANDROID_TOOLCHAIN_NAME} \
c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
