# Copyright (c) 2021, Mach1
# All rights reserved.

if(DEFINED POLLY_FLAGS_CORTEX_M0_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CORTEX_M0_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

set(
    _cortexm0_flags
    -pipe
    -march=armv6-m
    -mcpu=cortex-m0
    -mtune=cortex-m0
    -mthumb
    -msoft-float
    -mfloat-abi=soft
)

foreach(_cortexm0_flag ${_cortexm0_flags})
  polly_add_cache_flag(CMAKE_C_FLAGS "${_cortexm0_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_cortexm0_flag}")
endforeach()

# generate code that works best on the specified hardware
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "cortex-m0")
