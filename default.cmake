# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_DEFAULT_CMAKE)
  return()
else()
  set(POLLY_DEFAULT_CMAKE 1)
endif()

# Don't use polly_init (no generator expected)
set(POLLY_TOOLCHAIN_NAME "Default")
set(POLLY_TOOLCHAIN_TAG "default")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
