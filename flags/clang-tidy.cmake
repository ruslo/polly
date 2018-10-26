# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_CLANG_TIDY_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_CLANG_TIDY_CMAKE_ 1)
endif()

set(CMAKE_CXX_CLANG_TIDY clang-tidy)
set(CMAKE_C_CLANG_TIDY clang-tidy)
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "clang-tidy")
