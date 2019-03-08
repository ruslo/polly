# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_VS_PLATFORM_WIN32_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_VS_PLATFORM_WIN32_CMAKE_ 1)
endif()

# https://cmake.org/cmake/help/latest/generator/Visual%20Studio%2016%202019.html#platform-selection
set(CMAKE_GENERATOR_PLATFORM Win32 CACHE STRING "Platform" FORCE)
