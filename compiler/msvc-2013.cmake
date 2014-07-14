# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_MSVC_2013_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_MSVC_2013_CMAKE_ 1)
endif()

set(HUNTER_MSVC_VCVARSALL "$ENV{VS120COMNTOOLS}/../../VC/vcvarsall.bat")
