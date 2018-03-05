# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_UTILITIES_COMMON_CMAKE)
  return()
else()
  set(POLLY_UTILITIES_COMMON_CMAKE 1)
endif()

option(POLLY_STATUS_PRINT "Print process messages" ON)
option(POLLY_STATUS_DEBUG "Print all process messages" OFF)

# Add extra cmake modules
include("${CMAKE_CURRENT_LIST_DIR}/polly_module_path.cmake")

include(polly_fatal_error)
include(polly_status_debug)
include(polly_status_print)

# All well-known variables must be CACHE type:
#     http://www.cmake.org/pipermail/cmake/2012-January/048429.html

# Check and print customization variables
if(NOT POLLY_TOOLCHAIN_NAME)
  polly_fatal_error("POLLY_TOOLCHAIN_NAME is empty")
endif()

if(NOT POLLY_TOOLCHAIN_TAG)
  polly_fatal_error("POLLY_TOOLCHAIN_TAG is empty")
endif()

polly_status_print("Used toolchain: ${POLLY_TOOLCHAIN_NAME}")
polly_status_debug("Used tag: ${POLLY_TOOLCHAIN_TAG}")

# support for hunter (github.com/ruslo/hunter)
set(HUNTER_INSTALL_TAG ${POLLY_TOOLCHAIN_TAG})

# Other
if(NOT CMAKE_DEBUG_POSTFIX)
  polly_status_debug("CMAKE_DEBUG_POSTFIX is empty")
  set(
      CMAKE_DEBUG_POSTFIX
      "d"
      CACHE
      STRING
      "Debug postfix (e.g. libmy.a libmyd.a)"
  )
  polly_status_debug("CMAKE_DEBUG_POSTFIX set to '${CMAKE_DEBUG_POSTFIX}'")
endif()
