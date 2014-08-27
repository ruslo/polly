# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBRARY_STD_NOLIBS_CMAKE)
  return()
else()
  set(POLLY_LIBRARY_STD_NOLIBS_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-nostdinc++")
polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-nodefaultlibs")
