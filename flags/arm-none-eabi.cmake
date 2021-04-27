# Copyright (c) 2021, Mach1
# All rights reserved.

if(DEFINED POLLY_FLAGS_ARM_LINUX_NONE_EABI_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_ARM_LINUX_NONE_EABI_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "--target=arm-none-eabi")
polly_add_cache_flag(CMAKE_C_FLAGS "--target=arm-none-eabi")
polly_add_cache_flag(CMAKE_ASM_FLAGS "--target=arm-none-eabi")
