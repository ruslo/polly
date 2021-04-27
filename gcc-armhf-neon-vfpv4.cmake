# Copyright (c) 2021, Mach1
# All rights reserved.

# install cross compiler on unix/macos
# - `brew tap ArmMbed/homebrew-formulae`
# - `brew install arm-none-eabi-gcc`

if(DEFINED POLLY_UNIX_GCC_ARMHF_NEON_VFPV4_)
  return()
else()
  set(POLLY_UNIX_GCC_ARMHF_NEON_VFPV4_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Linux / gcc / armhf / c++11 support / neon-vfpv4"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

# set system name, this sets the variable CMAKE_CROSSCOMPILING
set(CMAKE_SYSTEM_NAME Linux)
set(CROSS_COMPILE_TOOLCHAIN_PREFIX "arm-none-eabi")

include(
    "${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile-simple-layout.cmake"
)
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hardfloat.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/neon-vfpv4.cmake")

