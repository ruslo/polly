# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_MSVC_2012_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_MSVC_2012_CMAKE_ 1)
endif()

get_filename_component(
    HUNTER_MSVC_VCVARSALL
    "$ENV{VS110COMNTOOLS}/../../VC/vcvarsall.bat"
    ABSOLUTE
)

set(HUNTER_MSVC_YEAR 2012)
set(HUNTER_MSVC_VERSION 11)
