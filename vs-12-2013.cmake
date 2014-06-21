# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_DEFAULT_CMAKE)
  return()
else()
  set(POLLY_DEFAULT_CMAKE 1)
endif()

# Compatible with default Hunter settings:
# * https://github.com/ruslo/hunter/blob/master/cmake/Hunter
set(POLLY_TOOLCHAIN_NAME "Visual Studio 12 2013")
set(POLLY_TOOLCHAIN_TAG "vs-12-2013")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
