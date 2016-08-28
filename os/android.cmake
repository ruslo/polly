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

string(COMPARE EQUAL "${CMAKE_SYSTEM_VERSION}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("CMAKE_SYSTEM_VERSION is not defined")
endif()

set(CMAKE_SYSTEM_NAME "Android")

if(CMAKE_VERSION VERSION_LESS 3.7)
  polly_fatal_error("Minimum CMake version for Android is 3.7")
endif()
