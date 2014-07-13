# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_ARCH_MSVC_X64_CMAKE_)
  return()
else()
  set(POLLY_ARCH_MSVC_X64_CMAKE_ 1)
endif()

set(HUNTER_MSVC_ARCH "amd64")
