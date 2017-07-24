# Copyright (c) 2017, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_COMPILER_GCC_CROSS_COMPILE_RASPBERRY_PI_CMAKE)
  return()
else()
  set(POLLY_COMPILER_GCC_CROSS_COMPILE_RASPBERRY_PI_CMAKE 1)
endif()

include(polly_fatal_error)
include(polly_status_print)

# Detect Raspberry Pi host
set(_proc_cpuinfo "/proc/cpuinfo")
if(EXISTS "${_proc_cpuinfo}")
  # https://en.wikipedia.org/wiki/Raspberry_Pi#Specifications
  file(
      STRINGS
      "${_proc_cpuinfo}"
      _proc_cpuinfo_strings
      REGEX
      "^Hardware[\t ]*:[\t ]*BCM283(5|6|7)$"
  )
  string(COMPARE EQUAL "${_proc_cpuinfo_strings}" "" _is_empty)
  if(NOT _is_empty)
    polly_status_print("Raspberry Pi host")
    set(_usr_bin_cpp "/usr/bin/cpp")
    if(EXISTS "${_usr_bin_cpp}")
      # Needed for 'url_sha1_autotools' Hunter build scheme
      set(CMAKE_C_PREPROCESSOR "${_usr_bin_cpp}" CACHE PATH "Preprocessor")
    endif()
    return() # We are not cross-compiling, exit now.
  endif()
endif()

set(_rpi_error_msg) #if empty, then no errors!
string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
      "${_rpi_error_msg}\nRASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH environment variable not set. Set it to the absolute path of the \"bin\" directory for the toolchain"
  )
endif()

string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
      "${_rpi_error_msg}\nRASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX environment variable not set. Set it to the triplet of the toolchain (ex: arm-linux-gnueabihf)"
  )
endif()

string(COMPARE EQUAL
    "$ENV{RASPBERRYPI_CROSS_COMPILE_SYSROOT}"
    ""
    _is_empty
)
if(_is_empty)
  set(_rpi_error_msg
    "${_rpi_error_msg}\nRASPBERRYPI_CROSS_COMPILE_SYSROOT environment variable not set. Set it to the sysroot to be used"
  )
endif()

string(COMPARE NOTEQUAL
    "${_rpi_error_msg}"
    ""
    _has_errors
)
if(_has_errors)
  polly_fatal_error(
      "RaspberyPi Toolchain configuration failed:"
      ${_rpi_error_msg}
  )
endif()

# We shouldn't try to hardcore the path, since the cross compiler for the Mac
# needs to be in a "case-sensitive" file system
set(CROSS_COMPILE_TOOLCHAIN_PATH
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH}"
    CACHE PATH "RaspberryPi Toolchain Path"
)

# The prefix is what is known as the cross compiler triplet or quadruplet.
# ex: arm-unknown-linux-gnueabihf (note: no dash at the end)
set(CROSS_COMPILE_TOOLCHAIN_PREFIX
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}"
    CACHE STRING "RaspberryPi Toolchain Prefix"
)

# The sysroot for the cross compile
set(CROSS_COMPILE_SYSROOT
    "$ENV{RASPBERRYPI_CROSS_COMPILE_SYSROOT}"
    CACHE PATH "RaspberryPi sysroot"
)

include("${CMAKE_CURRENT_LIST_DIR}/gcc-cross-compile.cmake")

