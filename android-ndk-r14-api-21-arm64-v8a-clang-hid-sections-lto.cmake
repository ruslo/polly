# Copyright (c) 2015-2017, Ruslan Baratov
# Copyright (c) 2015, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R14_API_21_ARM64_V8A_CLANG_HID_SECTIONS_LTO_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R14_API_21_ARM64_V8A_CLANG_HID_SECTIONS_LTO_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r14")
set(CMAKE_SYSTEM_VERSION "21")
set(CMAKE_ANDROID_ARCH_ABI "arm64-v8a")
set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION "clang")

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${CMAKE_SYSTEM_VERSION} / ${CMAKE_ANDROID_ARCH_ABI} / \
Clang / c++11 support / data-sections / function-sections / LTO"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake") # before toolchain!
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/lto.cmake") # after os/android.cmake
