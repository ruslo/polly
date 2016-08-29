# Copyright (c) 2016, Michele Caini
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R11C_API_21_CPP_SHARED_ARMEABI_V7A_NEON_CLANG_36_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R11C_API_21_CPP_SHARED_ARMEABI_V7A_NEON_CLANG_36_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r11c")
set(ANDROID_NATIVE_API_LEVEL "21")
set(ANDROID_ABI "armeabi-v7a with NEON")
set(ANDROID_TOOLCHAIN_NAME "arm-linux-androideabi-clang3.6")
set(ANDROID_STL "c++_shared")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${ANDROID_NATIVE_API_LEVEL} / ${ANDROID_ABI} / ${ANDROID_STL} / ${ANDROID_TOOLCHAIN_NAME} \
c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
