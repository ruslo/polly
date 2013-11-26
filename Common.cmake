# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMMON_CMAKE)
  return()
else()
  set(POLLY_COMMON_CMAKE 1)
endif()

# Add extra cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/find")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/utilities")

# All well-known variables must be CACHE type:
#     http://www.cmake.org/pipermail/cmake/2012-January/048429.html

# Check and print customization variables
if(NOT POLLY_TOOLCHAIN_NAME)
  message(FATAL_ERROR "POLLY_TOOLCHAIN_NAME is empty")
endif()

if(NOT POLLY_TOOLCHAIN_TAG)
  message(FATAL_ERROR "POLLY_TOOLCHAIN_TAG is empty")
endif()

message(STATUS "[polly] Used toolchain: ${POLLY_TOOLCHAIN_NAME}")

# support for hunter (github.com/ruslo/hunter)
set(HUNTER_INSTALL_TAG ${POLLY_TOOLCHAIN_TAG})

# Other
if(NOT CMAKE_DEBUG_POSTFIX)
  set(
      CMAKE_DEBUG_POSTFIX
      "d"
      CACHE
      STRING
      "Debug postfix (e.g. libmy.a libmyd.a)"
  )
endif()
