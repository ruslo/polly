# Copyright (c) 2017, NeroBurner
# All rights reserved.

# install cross compiler on Ubuntu
# - sudo apt install g++-arm-linux-gnueabihf
# - with gfortran: sudo apt install gfortran-arm-linux-gnueabihf

if(DEFINED POLLY_LINUX_GCC_AARCH64_)
  return()
else()
  set(POLLY_LINUX_GCC_AARCH64_ 1)
endif()


# set system name, this sets the variable CMAKE_CROSSCOMPILING
set(CMAKE_SYSTEM_NAME Linux)

set(CROSS_COMPILE_TOOLCHAIN_PREFIX aarch64-linux-gnu)
set(CROSS_COMPILE_TOOLCHAIN_SUFFIX -6)
set(CROSS_COMPILE_TOOLCHAIN_PATH /usr/bin)

if ("${SYSROOT}" STREQUAL "")
  set(SYSROOT $ENV{SYSROOT})
endif()

set(CROSS_COMPILE_SYSROOT ${SYSROOT})


include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Linux / gcc / aarch64 / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")


set(CMAKE_CROSSCOMPILING_EMULATOR qemu-aarch64) # used for try_run calls

include(
    # "${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile-simple-layout.cmake"
    "${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile.cmake"
)
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
# include("${CMAKE_CURRENT_LIST_DIR}/flags/hardfloat.cmake")

