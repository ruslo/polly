# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_VC_MDD_ANDROID_CMAKE_)
  return()
else()
  set(POLLY_OS_VC_MDD_ANDROID_CMAKE_ 1)
endif()

include(polly_fatal_error)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "r10e" _is_good)
if(NOT _is_good)
  polly_fatal_error("Only r10e supported")
endif()

string(COMPARE EQUAL "${ANDROID_NATIVE_API_LEVEL}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("ANDROID_NATIVE_API_LEVEL not set")
endif()

set(
    CMAKE_VC_MDD_ANDROID_API_LEVEL
    "android-${ANDROID_NATIVE_API_LEVEL}"
    CACHE
    INTERNAL
    "Android API"
)

string(COMPARE EQUAL "${ANDROID_ABI}" "" _is_empty)
if(NOT _is_empty)
  polly_fatal_error("ANDROID_ABI should be empty")
endif()

string(COMPARE EQUAL "${ANDROID_TOOLCHAIN_NAME}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("ANDROID_TOOLCHAIN_NAME not set")
endif()

set(
    CMAKE_VC_MDD_ANDROID_PLATFORM_TOOLSET
    "${ANDROID_TOOLCHAIN_NAME}"
    CACHE
    INTERNAL
    "Android toolset"
)

set(
    CMAKE_VC_MDD_ANDROID_USE_OF_STL
    "gnustl_static"
    CACHE
    INTERNAL
    "STL variant"
)

set(
    CMAKE_SYSTEM_NAME
    "VCMDDAndroid"
    CACHE
    INTERNAL
    "System name"
)

set(_expected_platform_module "${CMAKE_ROOT}/Modules/Platform/VCMDDAndroid.cmake")

if(NOT EXISTS "${_expected_platform_module}")
  polly_fatal_error(
      "File not found:\n  ${_expected_platform_module}"
      "You are using non-patched CMake version!"
      "See http://cgold.readthedocs.io/en/latest/platforms/android/windows.html#experimental-cmake for fix."
  )
endif()
