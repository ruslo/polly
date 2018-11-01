# Copyright (c) 2014, 2018 Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_ANALYZE_CXX17_CMAKE_)
  return()
else()
  set(POLLY_ANALYZE_CXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Clang static analyzer / c++17 support"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")

set(CMAKE_CXX_COMPILER "${CMAKE_CURRENT_LIST_DIR}/scripts/clangxx-analyze.sh")
set(CMAKE_C_COMPILER "${CMAKE_CURRENT_LIST_DIR}/scripts/clang-analyze.sh")

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "analyze")

include("${CMAKE_CURRENT_LIST_DIR}/os/osx.cmake")
