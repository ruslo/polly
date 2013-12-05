# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG32_LIBSTDCXX_CMAKE)
  return()
else()
  set(POLLY_CLANG32_LIBSTDCXX_CMAKE 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "clang 3.2 / GNU Standard C++ Library (libstdc++) / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "clang32_libstdcxx")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang32.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libstdcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
