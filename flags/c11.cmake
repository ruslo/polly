# Copyright (c) 2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_C11_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_C11_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

# Do not add this flag to 'flags/cxx11':
# * FAIL: OpenSSL + gcc-4-8-c11
# * FAIL: lzma + gcc-4-8
polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-std=c11")

# Hunter doesn't run toolchain-id calculation for C compiler
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "c11")
