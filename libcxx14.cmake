# Copyright (c) 2013-2018, Ruslan Baratov
# Copyright (c) 2018, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_CLANG_LIBCXX_CXX14_CMAKE)
  return()
else()
  set(POLLY_CLANG_LIBCXX_CXX14_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang / LLVM Standard C++ Library (libc++) / c++14 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
