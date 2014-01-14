# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_SANITIZE_ADDRESS_CMAKE_)
  return()
else()
  set(POLLY_SANITIZE_ADDRESS_CMAKE_ 1)
endif()

set(
    POLLY_TOOLCHAIN_NAME
    "Clang address sanitizer / c++11 support"
)
set(POLLY_TOOLCHAIN_TAG "sanitize_address")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/sanitize_address.cmake")

set(HUNTER_DISABLE_SHARED_LIBS YES)
