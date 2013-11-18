# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CUSTOM_LIBCXX_CMAKE)
  return()
else()
  set(POLLY_CUSTOM_LIBCXX_CMAKE 1)
endif()

set(POLLY_TOOLCHAIN_NAME "Custom libc++")
set(POLLY_TOOLCHAIN_TAG "custom_libcxx")

include("${CMAKE_CURRENT_LIST_DIR}/Common.cmake")

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++ -nostdinc++" 
    CACHE
    STRING
    "C++ compiler flags"
)

# '-lSystem' needed to fix broken compiler report
set(
    CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -nodefaultlibs -lSystem"
    CACHE
    STRING
    "C++ linker flags"
)

set(CUSTOM_LIBCXX_LIBRARY_LOCATION TRUE)
