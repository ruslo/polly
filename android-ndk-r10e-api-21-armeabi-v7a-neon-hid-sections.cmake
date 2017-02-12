# Copyright (c) 2015, Ruslan Baratov
# Copyright (c) 2015, David Hirvonen
# Copyright (c) 2015, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R10E_API_21_ARMEABI_V7A_NEON_HID_SECTIONS_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R10E_API_21_ARMEABI_V7A_NEON_HID_SECTIONS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r10e")
set(CMAKE_SYSTEM_VERSION "21")
set(CMAKE_ANDROID_ARCH_ABI "armeabi-v7a")
set(CMAKE_ANDROID_ARM_NEON TRUE)
set(CMAKE_ANDROID_ARM_MODE TRUE) # 32-bit ARM

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${CMAKE_SYSTEM_VERSION} / ${CMAKE_ANDROID_ARCH_ABI} / \
NEON / 32-bit ARM / c++11 support / hidden / function-sections / data-sections"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
