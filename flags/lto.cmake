# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_LTO_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_LTO_CMAKE_ 1)
endif()

include(polly_add_cache_flag)
include(polly_fatal_error)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-flto")
  polly_add_cache_flag(CMAKE_C_FLAGS "-flto")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-flto")
  polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-flto")

  string(COMPARE EQUAL "${CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION}" "clang" _is_clang)

  if(_is_clang)
    # Fix for error "format not recognized"
    # (tested with 'android-ndk-r14-api-21-arm64-v8a-clang-hid-sections-lto')
    polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS_INIT "-fuse-ld=gold")
    polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS_INIT "-fuse-ld=gold")
  else()
    # GCC, fix for "BFD: ... : plugin needed to handle lto object"
    if(CMAKE_HOST_WIN32)
      set(_host_tag "windows")
    elseif(CMAKE_HOST_APPLE)
      set(_host_tag "darwin")
    else()
      set(_host_tag "linux")
    endif()

    set(
        CMAKE_AR
        "${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/${_host_tag}-x86_64/bin/arm-linux-androideabi-gcc-ar"
        CACHE
        PATH
        ""
        FORCE
    )

    set(
        CMAKE_RANLIB
        "${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/${_host_tag}-x86_64/bin/arm-linux-androideabi-gcc-ranlib"
        CACHE
        PATH
        ""
        FORCE
    )
  endif()
endif()

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "lto")
