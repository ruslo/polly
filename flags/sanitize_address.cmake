# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_ADDRESS_CMAKE_ 1)
endif()

include(polly_add_cache_flag)
include(polly_fatal_error)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize=address")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-g")

set(
    CMAKE_CXX_FLAGS_RELEASE
    "-O1 -DNDEBUG"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)

polly_add_cache_flag(CMAKE_C_FLAGS "-fsanitize=address")
polly_add_cache_flag(CMAKE_C_FLAGS "-g")

set(
    CMAKE_C_FLAGS_RELEASE
    "-O1 -DNDEBUG"
    CACHE
    STRING
    "C compiler flags"
    FORCE
)

if(XCODE)
  polly_add_cache_flag(CMAKE_C_FLAGS "-D_LIBCPP_HAS_NO_ASAN")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-D_LIBCPP_HAS_NO_ASAN")

  string(COMPARE EQUAL "${CMAKE_XCODE_ATTRIBUTE_CC}" "" _is_empty)
  if(_is_empty)
    polly_fatal_error("CMAKE_XCODE_ATTRIBUTE_CC is empty")
  endif()

  get_filename_component(_xcode_root "${CMAKE_XCODE_ATTRIBUTE_CC}" DIRECTORY)

  set(_xcode_asan_lib_name "libclang_rt.asan_osx_dynamic")
  set(
      _xcode_asan_pattern
      "${_xcode_root}/../lib/clang/*/lib/darwin/${_xcode_asan_lib_name}.dylib"
  )

  file(GLOB _xcode_asan_lib "${_xcode_asan_pattern}")
  list(LENGTH _xcode_asan_lib _xcode_asan_lib_length)
  if(_xcode_asan_lib_length EQUAL 1)
    get_filename_component(_xcode_asan_lib "${_xcode_asan_lib}" ABSOLUTE)
    get_filename_component(_xcode_asan_lib_dir "${_xcode_asan_lib}" DIRECTORY)
    polly_status_debug("Using ASAN library:\n")
    polly_status_debug("  * ${_xcode_asan_lib}")
  elseif(_xcode_asan_lib_length EQUAL 0)
    polly_fatal_error("File not found by pattern: ${_xcode_asan_pattern}")
  else()
    polly_fatal_error("Unexpected: '${_xcode_asan_lib}'")
  endif()

  polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "${_xcode_asan_lib}")
  polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "${_xcode_asan_lib}")

  # FIXME: http://www.mail-archive.com/cmake-developers@cmake.org/msg17290.html {
  polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,${_xcode_asan_lib_dir}")
  polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-Wl,-rpath,${_xcode_asan_lib_dir}")
  # }

  # Hunter copying rules {
  set_property(GLOBAL APPEND PROPERTY HUNTER_COPY_FILES "${_xcode_asan_lib}")
  # Do not use SOURCE property because it's visible only for current directory
  set_property(GLOBAL PROPERTY "HUNTER_DST_RELATIVE_DIR_${_xcode_asan_lib}" "lib")
  # }
endif()
