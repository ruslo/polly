# Copyright (c) 2017, NeroBurner
# All rights reserved.

# install cross compiler on Ubuntu
# - sudo apt install g++-arm-linux-gnueabihf
# - with gfortran: sudo apt install gfortran-arm-linux-gnueabihf

if(DEFINED POLLY_LINUX_GCC_JETSON_TK1_)
  return()
else()
  set(POLLY_LINUX_GCC_JETSON_TK1_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Linux / gcc / armhf / c++11 support / neon-vfpv4 / cortex-a15"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

# set system name, this sets the variable CMAKE_CROSS_COMPILING
set(CMAKE_SYSTEM_NAME Linux)
set(CROSS_COMPILE_TOOLCHAIN_PREFIX "arm-linux-gnueabihf")
set(CMAKE_CROSSCOMPILING_EMULATOR qemu-arm) # used for try_run calls

include(
    "${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile-simple-layout.cmake"
)
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hardfloat.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/neon-vfpv4.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/mtune_cortex-a15.cmake")

