# Copyright (c) 2017, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_OS_RASPBERRY_PI1_CMAKE)
  return()
else()
  set(POLLY_OS_RASPBERRY_PI1_CMAKE 1)
endif()

include(polly_add_cache_flag)

# -mcpu=arm1176jzf-s not compatible, removed
foreach(_flag -mfpu=vfp)
  polly_add_cache_flag(CMAKE_C_FLAGS   "${_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_flag}")
endforeach()

set(CMAKE_SYSTEM_PROCESSOR "armv6" CACHE INTERNAL "")
set(RASPBERRY_PI 1 CACHE INTERNAL "")
set(CMAKE_SYSTEM_NAME "Linux" CACHE INTERNAL "")
