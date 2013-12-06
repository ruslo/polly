# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_LIBRARY_STD_LIBSTDCXX_CMAKE)
  return()
else()
  set(POLLY_LIBRARY_STD_LIBSTDCXX_CMAKE 1)
endif()

set(
    CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -stdlib=libstdc++"
    CACHE
    STRING
    "C++ compiler flags"
    FORCE
)

set(
    CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libstdc++"
    CACHE
    STRING
    "Executable linker flags"
    FORCE
)

set(
    CMAKE_SHARED_LINKER_FLAGS
    "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libstdc++"
    CACHE
    STRING
    "Shared library linker flags"
    FORCE
)
