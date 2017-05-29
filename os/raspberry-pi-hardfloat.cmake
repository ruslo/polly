# Copyright (c) 2017, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_OS_RASPBERRY_PI_HARDFLOAT_CMAKE)
  return()
else()
  set(POLLY_OS_RASPBERRY_PI_HARDFLOAT_CMAKE 1)
endif()

include(polly_add_cache_flag)

foreach(_flag -mfloat-abi=hard -mlittle-endian -munaligned-access)
  polly_add_cache_flag(CMAKE_C_FLAGS   "${_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_flag}")
endforeach()

set(CMAKE_SYSTEM_NAME "Linux" CACHE STRING "")

