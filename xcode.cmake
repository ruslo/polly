# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_XCODE_CMAKE_)
  return()
else()
  set(POLLY_XCODE_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Xcode / LLVM Standard C++ Library (libc++) / c++11 support"
    "Xcode"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

execute_process(
    COMMAND
    xcrun --find clang
    OUTPUT_VARIABLE
    CMAKE_C_COMPILER
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND
    xcrun --find clang++
    OUTPUT_VARIABLE
    CMAKE_CXX_COMPILER
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(CMAKE_C_COMPILER ${CMAKE_C_COMPILER} CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER ${CMAKE_CXX_COMPILER} CACHE STRING "C++ compiler" FORCE)

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")
