# Copyright (c) 2015 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_GCC_CROSS_COMPILE_SIMPLE_LAYOUT_)
  return()
else()
  set(POLLY_COMPILER_GCC_CROSS_COMPILE_SIMPLE_LAYOUT_ TRUE)
endif()

string(COMPARE EQUAL "${CROSS_COMPILE_TOOLCHAIN_PREFIX}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("CROSS_COMPILE_TOOLCHAIN_PREFIX not set.")
endif()

set(_gcc_name "${CROSS_COMPILE_TOOLCHAIN_PREFIX}-gcc")
find_program(_gcc_location "${_gcc_name}")
if(NOT _gcc_location)
  polly_fatal_error(
      "GCC not found: ${_gcc_name} (update PATH environment variable)"
  )
endif()

get_filename_component(
    CROSS_COMPILE_TOOLCHAIN_PATH "${_gcc_location}" DIRECTORY
)
get_filename_component(
    CROSS_COMPILE_SYSROOT "${CROSS_COMPILE_TOOLCHAIN_PATH}/.." ABSOLUTE
)

set(POLLY_SKIP_SYSROOT YES)
include("${CMAKE_CURRENT_LIST_DIR}/gcc-cross-compile.cmake")
