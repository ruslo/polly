# Copyright (c) 2013-2016, Ruslan Baratov
# Copyright (c) 2016, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_FLAGS_FUNCTION_SECTIONS_CMAKE)
  return()
else()
  set(POLLY_FLAGS_FUNCTION_SECTIONS_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-ffunction-sections")
polly_add_cache_flag(CMAKE_C_FLAGS "-ffunction-sections")

# There is no macro to detect this flags on toolchain calculation so we must
# mark this toolchain explicitly.
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "function-sections")
