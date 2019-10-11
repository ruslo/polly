# Copyright (c) 2015, 2017 Alexandre Pretyman
# Copyright (c) 2019 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_RASPBERRYPI3_CLANG_CXX14_PIC_CMAKE_)
  return()
else()
  set(POLLY_RASPBERRYPI3_CLANG_CXX14_PIC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "RaspberryPi 3 Cross Compile / Clang / C++14 / PIC"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_clear_environment_variables)

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang-tools.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/lld.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/arm-linux-gnueabihf.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/rpi-sysroot.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/raspberry-pi3.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/raspberry-pi-hardfloat.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
