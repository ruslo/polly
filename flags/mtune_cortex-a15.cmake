# Copyright (c) 2017, NeroBurner
# All rights reserved.

if(DEFINED POLLY_FLAGS_MTUNE_CORTEX-A15_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_MTUNE_CORTEX-A15_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

# generate code that works best on the specified hardware
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "cortex-a15")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-mtune=cortex-a15")
polly_add_cache_flag(CMAKE_C_FLAGS "-mtune=cortex-a15")

