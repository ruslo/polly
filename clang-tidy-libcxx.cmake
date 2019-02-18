# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG_TIDY_LIBCXX_CMAKE_)
  return()
else()
  set(POLLY_CLANG_TIDY_LIBCXX_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang tidy / LLVM Standard C++ Library (libc++) / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/clang-tidy.cmake")
