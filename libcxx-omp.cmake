# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG_OMP_LIBCXX_CXX11_CMAKE)
  return()
else()
  set(POLLY_CLANG_OMP_LIBCXX_CXX11_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang-omp / LLVM Standard C++ Library (libc++) / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang-omp.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
