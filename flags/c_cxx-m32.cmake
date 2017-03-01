# Copyright (c) 2017, IDscan Biometrics
# All rights reserved.

if(DEFINED POLLY_FLAGS_C_CXX_M32_CMAKE)
  return()
else()
  set(POLLY_FLAGS_C_CXX_M32_CMAKE 1)
endif()

include(polly_add_cache_flag)

# Force 32-bit code generation.
polly_add_cache_flag(CMAKE_CXX_FLAGS "-m32")
polly_add_cache_flag(CMAKE_C_FLAGS "-m32")
