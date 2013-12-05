# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBRARY_STD_LIBCXX_CMAKE)
  return()
else()
  set(POLLY_LIBRARY_STD_LIBCXX_CMAKE 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -stdlib=libc++"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)

# For Xcode
set(
    CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++"
    CACHE
    STRING
    "C++ linker flags"
    FORCE
)
