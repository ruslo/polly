# Copyright (c) 2015-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_STATIC_STD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_STATIC_STD_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-static-libgcc")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-static-libstdc++")

polly_add_cache_flag(CMAKE_C_FLAGS "-static-libgcc")

# There is no macro to detect this flags on toolchain calculation so we must
# mark this toolchain explicitly.
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "static-std-v2")
