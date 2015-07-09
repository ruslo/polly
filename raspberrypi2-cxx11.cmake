# Copyright (c) 2015, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_RASPBERRYPI2_CXX11_CMAKE)
  return()
else()
  set(POLLY_RASPBERRYPI2_CXX11_CMAKE 1)
endif()

#Maybe this line should be in polly_init and not in polly_common?
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/utilities")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")
include(polly_clear_environment_variables)
include(polly_fatal_error)
include(polly_add_cache_flag)

polly_init(
    "RaspberryPi 2 Cross Compile / C++11"
    "Unix Makefiles"
)
set(RAPSBERRYPI2_COMPILE_FLAGS
    "-mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
    CACHE STRING "RaspberryPi 2 Compile Flags"
)

# We shouldn't try to hardcore the path, since the cross compiler for the Mac
# needs to be in a "case-sensitive" file system
set(CROSS_COMPILE_TOOLCHAIN_PATH
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH}"
    CACHE PATH "RaspberryPi Toolchain Path"
)

# The prefix is what is known as the cross compiler triplet or quadruplet.
# ex: arm-unknown-linux-gnueabihf (note: no dash at the end)
set(CROSS_COMPILE_TOOLCHAIN_PREFIX
    "$ENV{RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX}"
    CACHE STRING "RaspberryPi Toolchain Prefix"
)

# The sysroot is sometimes optional, as it could be hardcoded into the compiler
set(CROSS_COMPILE_SYSROOT
    "$ENV{RASPBERRYPI_CROSS_COMPILE_SYSROOT}"
    CACHE PATH "RaspberryPi sysroot"
)

include(polly_common)
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile.cmake")

polly_add_cache_flag(CMAKE_C_FLAGS ${RAPSBERRYPI2_COMPILE_FLAGS})
polly_add_cache_flag(CMAKE_CXX_FLAGS ${RAPSBERRYPI2_COMPILE_FLAGS})
polly_add_cache_flag(CMAKE_SYSTEM_NAME "Linux")
polly_add_cache_flag(CMAKE_SYSTEM_PROCESSOR "armv7-a")
