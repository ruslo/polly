# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_CUSTOM_LIBCXX_CMAKE)
  return()
else()
  set(POLLY_CUSTOM_LIBCXX_CMAKE 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "clang / Custom LLVM Standard C++ Library (libc++) / c++11 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/nolibs.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

# '-lSystem' needed to fix broken compiler report
set(
    CMAKE_EXE_LINKER_FLAGS
    "${CMAKE_EXE_LINKER_FLAGS} -lSystem"
    CACHE
    STRING
    "C++ linker flags"
    FORCE
)

set(CUSTOM_LIBCXX_LIBRARY_LOCATION TRUE)
