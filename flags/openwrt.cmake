# Copyright (c) 2017, NeroBurner
# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_OPENWRT_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_OPENWRT_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

set(
    _openwrt_flags
    -pipe
    -march=armv7-a
    -mcpu=cortex-a9
    -mtune=cortex-a9
    -msoft-float
    -mfloat-abi=soft
    -fno-caller-saves
    -fno-plt
    "-DNEED_PRINTF=1" # http://www.dd-wrt.com/phpBB2/viewtopic.php?p=552124
)

foreach(_openwrt_flag ${_openwrt_flags})
  polly_add_cache_flag(CMAKE_C_FLAGS "${_openwrt_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_openwrt_flag}")
endforeach()
