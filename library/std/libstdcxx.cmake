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
