# Copyright (c) 2015, Ruslan Baratov, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R10E_API_16_X86_HID_SECTIONS_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R10E_API_16_X86_HID_SECTIONS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_FORCE_ARM_BUILD "OFF")
set(ANDROID_NDK_VERSION "r10e")
set(ANDROID_NATIVE_API_LEVEL "16")
set(ANDROID_ABI "x86")
set(ANDROID_TOOLCHAIN_NAME "x86-4.9")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${ANDROID_NATIVE_API_LEVEL} / ${ANDROID_ABI} / \
hidden visibility / \
c++11 support / data-sections / function-sections"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
