# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_RPI_SYSROOT_CMAKE_)
  return()
else()
  set(POLLY_OS_RPI_SYSROOT_CMAKE_ 1)
endif()

include(polly_fatal_error)

if("$ENV{RPI_SYSROOT}" STREQUAL "")
  polly_fatal_error("Environment variable RPI_SYSROOT is not set")
endif()

set(__dir_to_check "$ENV{RPI_SYSROOT}/usr/include")
if(NOT EXISTS "${__dir_to_check}")
  polly_fatal_error(
      "Directory not found: '${__dir_to_check}'."
      " Please verify RPI_SYSROOT environment variable"
  )
endif()
unset(__dir_to_check)

set(CMAKE_SYSROOT "$ENV{RPI_SYSROOT}" CACHE PATH "Raspberry Pi sysroot" FORCE)
