# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG_LIBCXX_CXX11_CMAKE)
  return()
else()
  set(POLLY_CLANG_LIBCXX_CXX11_CMAKE 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "clang / LLVM Standard C++ Library (libc++) / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "libcxx")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
