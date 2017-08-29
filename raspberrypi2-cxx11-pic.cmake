# Copyright (c) 2015, 2017 Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_RASPBERRYPI2_CXX11_CMAKE)
  return()
else()
  set(POLLY_RASPBERRYPI2_CXX11_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "RaspberryPi 2 Cross Compile / C++11 / PIC"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include(polly_clear_environment_variables)

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/gcc-cross-compile-raspberry-pi.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/raspberry-pi2.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/raspberry-pi-hardfloat.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
