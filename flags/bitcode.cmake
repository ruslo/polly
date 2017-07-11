# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_BITCODE_)
  return()
else()
  set(POLLY_FLAGS_BITCODE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fembed-bitcode")

# We can't use 'ENABLE_BITCODE' because
# it only adds '-fembed-bitcode-marker':
# * https://stackoverflow.com/a/31346742

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "bitcode.2")
