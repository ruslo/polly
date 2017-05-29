# Copyright (c) 2017, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_OS_RASPBERRY_PI2_CMAKE)
  return()
else()
  set(POLLY_OS_RASPBERRY_PI2_CMAKE 1)
endif()

include(polly_add_cache_flag)

foreach(_flag -mcpu=cortex-a7 -mfpu=neon-vfpv4)
  polly_add_cache_flag(CMAKE_C_FLAGS   "${_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_flag}")
endforeach()

set(CMAKE_SYSTEM_PROCESSOR "armv7-a" CACHE INTERNAL "")
set(RASPBERRY_PI 2 CACHE INTERNAL "")

