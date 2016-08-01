# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_VC_MDD_ANDROID_CMAKE_)
  return()
else()
  set(POLLY_OS_VC_MDD_ANDROID_CMAKE_ 1)
endif()

cmake_minimum_required(VERSION 3.4)

include(polly_fatal_error)

if("${ANDROID_NDK_VERSION}" STREQUAL "")
  polly_fatal_error("ANDROID_NDK_VERSION not set")
endif()

if("${ANDROID_NATIVE_API_LEVEL}" STREQUAL "")
  polly_fatal_error("ANDROID_NATIVE_API_LEVEL not set")
endif()

set(
    CMAKE_VC_MDD_ANDROID_API_LEVEL
    "android-${ANDROID_NATIVE_API_LEVEL}"
    CACHE
    INTERNAL
    "Android API"
)

if("${ANDROID_ABI}" STREQUAL "")
  polly_fatal_error("ANDROID_ABI not set")
endif()

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

set(ANDROID "TRUE" CACHE STRING "Is platform Android?")

get_filename_component(
    ANDROID_NDK
    "[HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\VisualStudio\\14.0_Config\\Setup\\vs\\SecondaryInstaller\\AndroidNDK64;NDK_HOME]"
    ABSOLUTE
    CACHE
)

if(EXISTS "${ANDROID_NDK}")
  polly_status_debug("Android NDK: ${ANDROID_NDK}")
else()
  polly_fatal_error("Directory not found: ${ANDROID_NDK}")
endif()

get_filename_component(_android_dirname "${ANDROID_NDK}" NAME)
if(NOT "${_android_dirname}" STREQUAL "android-ndk-${ANDROID_NDK_VERSION}")
  polly_fatal_error(
      "Inconsistent ANDROID_NDK_VERSION/ANDROID_NDK:"
      "  ${ANDROID_NDK_VERSION}/${ANDROID_NDK}"
  )
endif()

get_filename_component(
    ANDROID_ANT_HOME
    "[HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\VisualStudio\\14.0_Config\\Setup\\vs\\SecondaryInstaller\\Ant;ANT_HOME]"
    ABSOLUTE
    CACHE
)

if(EXISTS "${ANDROID_ANT_HOME}")
  polly_status_debug("Ant HOME: ${ANDROID_ANT_HOME}")
else()
  polly_fatal_error("Directory not found: ${ANDROID_ANT_HOME}")
endif()

if("${ANDROID_ABI}" STREQUAL "armeabi")
  set(ANDROID_ARCH_NAME "arm")
elseif("${ANDROID_ABI}" STREQUAL "mips")
  set(ANDROID_ARCH_NAME "mips")
elseif("${ANDROID_ABI}" STREQUAL "x86")
  set(ANDROID_ARCH_NAME "x86")
else()
  polly_fatal_error("Unexpected ANDROID_ABI: ${ANDROID_ABI}")
endif()

if("${ANDROID_ARCH_NAME}" STREQUAL "x86")
  set(ANDROID_TOOLCHAIN_NAME "x86-4.9")
  set(ANDROID_TOOLCHAIN_MACHINE_NAME "i686-linux-android")
elseif("${ANDROID_ARCH_NAME}" STREQUAL "arm")
  set(ANDROID_TOOLCHAIN_NAME "arm-linux-androideabi-4.9")
  set(ANDROID_TOOLCHAIN_MACHINE_NAME "arm-linux-androideabi")
else()
  polly_fatal_error("Unexpected ANDROID_ARCH_NAME: ${ANDROID_ARCH_NAME}")
endif()

set(ANDROID_TOOLCHAIN_ROOT "${ANDROID_NDK}/toolchains/${ANDROID_TOOLCHAIN_NAME}/prebuilt/windows-x86_64")
if(NOT EXISTS "${ANDROID_TOOLCHAIN_ROOT}")
  polly_fatal_error("Directory not found: ${ANDROID_TOOLCHAIN_ROOT}")
endif()

set(
    ANDROID_SYSROOT
    "${ANDROID_NDK}/platforms/android-${ANDROID_NATIVE_API_LEVEL}/arch-${ANDROID_ARCH_NAME}"
    CACHE
    INTERNAL
    "Android system root"
)

if(NOT EXISTS "${ANDROID_SYSROOT}")
  polly_fatal_error("Directory not found: ${ANDROID_SYSROOT}")
endif()

set(_dir1 "${ANDROID_TOOLCHAIN_ROOT}/bin")
if(NOT EXISTS "${_dir1}")
  polly_fatal_error("Directory not found: ${_dir1}")
endif()

set(_dir2 "${ANDROID_TOOLCHAIN_ROOT}/${ANDROID_TOOLCHAIN_MACHINE_NAME}")
if(NOT EXISTS "${_dir2}")
  polly_fatal_error("Directory not found: ${_dir2}")
endif()

set(CMAKE_FIND_ROOT_PATH "${_dir1}" "${_dir2}" "${ANDROID_SYSROOT}")

# Support AndroidApk.cmake (https://github.com/hunter-packages/android-apk) {

set(
    ANDROID_ANT_COMMAND
    "${ANDROID_ANT_HOME}/bin/ant.bat"
    CACHE
    INTERNAL
    "Path to ant"
)

set(
    CMAKE_GDBSERVER
    "${ANDROID_NDK}/prebuilt/android-${ANDROID_ARCH_NAME}/gdbserver/gdbserver"
    CACHE
    INTERNAL
    "Path to 'gdbserver'"
)
if(NOT EXISTS "${CMAKE_GDBSERVER}")
  polly_fatal_error("File not found: ${CMAKE_GDBSERVER}")
endif()

set(ANDROID_API_LEVEL "${ANDROID_NATIVE_API_LEVEL}")

# only search for libraries and includes in the ndk toolchain
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# macro to find packages on the host OS
macro(find_host_package)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
 if(CMAKE_HOST_WIN32)
  set(WIN32 1)
  set(UNIX)
 elseif(CMAKE_HOST_APPLE)
  set(APPLE 1)
  set(UNIX)
 endif()
 find_package(${ARGN})
 set(WIN32)
 set(APPLE)
 set(UNIX 1)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endmacro()

# macro to find programs on the host OS
macro(find_host_program)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
 if(CMAKE_HOST_WIN32)
  set(WIN32 1)
  set(UNIX)
 elseif(CMAKE_HOST_APPLE)
  set(APPLE 1)
  set(UNIX)
 endif()
 find_program(${ARGN})
 set(WIN32)
 set(APPLE)
 set(UNIX 1)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endmacro()

# }
