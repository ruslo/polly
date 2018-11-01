# Copyright (c) 2013, 2018 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_VS_ZW_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_VS_ZW_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

# https://msdn.microsoft.com/en-us/library/hh561383.aspx
polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "/ZW")
polly_add_cache_flag(CMAKE_C_FLAGS_INIT "/ZW")
