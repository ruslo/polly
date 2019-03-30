# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_VS_VERSION_14_11_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_VS_VERSION_14_11_CMAKE_ 1)
endif()

set(CMAKE_GENERATOR_TOOLSET "version=14.11" CACHE STRING "..." FORCE)
