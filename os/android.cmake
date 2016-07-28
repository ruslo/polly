# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_ANDROID_CMAKE_)
  return()
else()
  set(POLLY_OS_ANDROID_CMAKE_ 1)
endif()

include(polly_fatal_error)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("ANDROID_NDK_VERSION is not defined")
endif()

set(_env_ndk "$ENV{ANDROID_NDK_${ANDROID_NDK_VERSION}}")
string(COMPARE EQUAL "${_env_ndk}" "" _is_empty)
if(NOT _is_empty)
  set(ANDROID_NDK "${_env_ndk}")
endif()

string(COMPARE EQUAL "${ANDROID_NATIVE_API_LEVEL}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("ANDROID_NATIVE_API_LEVEL is not defined")
endif()

set(ANDROID_API_LEVEL "${ANDROID_NATIVE_API_LEVEL}") # Need for Apk.cmake module
option(ANDROID_FORCE_COMPILERS "" OFF)
include("${CMAKE_CURRENT_LIST_DIR}/android.toolchain.cmake")

# Toolchain can "adjust" API level silently
string(
    COMPARE EQUAL "${ANDROID_API_LEVEL}" "${ANDROID_NATIVE_API_LEVEL}" _is_equal
)
if(NOT _is_equal)
  polly_fatal_error(
      "API level adjusted:"
      "  ANDROID_API_LEVEL: ${ANDROID_API_LEVEL}"
      "  ANDROID_NATIVE_API_LEVEL: ${ANDROID_NATIVE_API_LEVEL}"
  )
endif()

# Support for Android-Apk: https://github.com/hunter-packages/android-apk
set(
    CMAKE_GDBSERVER
    "${ANDROID_NDK}/prebuilt/android-${ANDROID_ARCH_NAME}/gdbserver/gdbserver"
)
if(NOT EXISTS "${CMAKE_GDBSERVER}")
  polly_fatal_error(
      "gdbserver not found. Expected location: ${CMAKE_GDBSERVER}"
  )
endif()
