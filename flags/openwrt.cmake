# Copyright (c) 2017, NeroBurner
# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_DDWRT_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_DDWRT_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

set(
    _ddwrt_flags
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

foreach(_ddwrt_flag ${_ddwrt_flags})
  polly_add_cache_flag(CMAKE_C_FLAGS "${_ddwrt_flag}")
  polly_add_cache_flag(CMAKE_CXX_FLAGS "${_ddwrt_flag}")
endforeach()
