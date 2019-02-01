# Copyright (c) 2016-2017, Ruslan Baratov
# Copyright (c) 2017, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_CLANG_7_CMAKE_)
  return()
else()
  set(POLLY_CLANG_7_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang 7"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang-7.cmake")

include(polly_add_cache_flag)
polly_add_cache_flag(CMAKE_CXX_FLAGS "-stdlib=libc++")
polly_add_cache_flag(CMAKE_EXE_LINKER_FLAGS "-stdlib=libc++")
polly_add_cache_flag(CMAKE_SHARED_LINKER_FLAGS "-stdlib=libc++")
include_directories(SYSTEM /usr/lib/llvm-7/include/c++/v1)
