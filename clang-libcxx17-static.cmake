# Copyright (c) 2013, 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CLANG_LIBCXX17_STATIC_CMAKE_)
  return()
else()
  set(POLLY_CLANG_LIBCXX17_STATIC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang / LLVM Standard C++ Library (libc++) / c++17 support / static"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/static.cmake")

# Fix linker errors {
# - https://stackoverflow.com/a/53395190
polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-lc++abi")
polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-pthread")
polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld")

polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-lc++abi")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-pthread")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-fuse-ld=lld")
# }

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
