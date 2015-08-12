# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_MSVC_2010_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_MSVC_2010_CMAKE_ 1)
endif()

get_filename_component(
    HUNTER_MSVC_VCVARSALL
    "$ENV{VS100COMNTOOLS}/../../VC/vcvarsall.bat"
    ABSOLUTE
)
