# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_LLD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_LLD_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-fuse-ld=lld")
polly_add_cache_flag(CMAKE_MODULE_LINKER_FLAGS "-fuse-ld=lld")
