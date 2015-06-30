# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_MSVC_2005_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_MSVC_2005_CMAKE_ 1)
endif()

get_filename_component(
    HUNTER_MSVC_VCVARSALL
    "$ENV{VS80COMNTOOLS}/../../VC/vcvarsall.bat"
    ABSOLUTE
)
