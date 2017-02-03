# Copyright (c) 2017, IDscan Biometrics Ltd.
# All rights reserved.

if(DEFINED POLLY_FLAGS_CXX11_ABI_DISABLE_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CXX11_ABI_DISABLE_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-D_GLIBCXX_USE_CXX11_ABI=0")
polly_add_cache_flag(CMAKE_C_FLAGS "-D_GLIBCXX_USE_CXX11_ABI=0")
