# Copyright (c) 2013, 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBRARY_STD_LIBCXX_CMAKE)
  return()
else()
  set(POLLY_LIBRARY_STD_LIBCXX_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-stdlib=libc++")

if(XCODE)
  if(XCODE_VERSION VERSION_LESS 6)
    polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-stdlib=libc++")
    polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-stdlib=libc++")
  endif()
endif()
