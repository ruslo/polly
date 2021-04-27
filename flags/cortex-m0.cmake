# Copyright (c) 2021, Mach1
# All rights reserved.

if(DEFINED POLLY_FLAGS_CORTEX_M0_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CORTEX_M0_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

# generate code that works best on the specified hardware
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "cortex-m0")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-mcpu=cortex-m0")
polly_add_cache_flag(CMAKE_C_FLAGS "-mcpu=cortex-m0")
