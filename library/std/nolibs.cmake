# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBRARY_STD_NOLIBS_CMAKE)
  return()
else()
  set(POLLY_LIBRARY_STD_NOLIBS_CMAKE 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -nostdinc++"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)

set(
    CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -nodefaultlibs"
    CACHE
    STRING
    "C++ linker flags"
    FORCE
)
