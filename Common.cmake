# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMMON_CMAKE)
  return()
else()
  set(POLLY_COMMON_CMAKE 1)
endif()

# All well-known variables must be CACHE type:
#     http://www.cmake.org/pipermail/cmake/2012-January/048429.html

# Try to detect GITENV_ROOT
if(NOT GITENV_ROOT)
  set(GITENV_ROOT $ENV{GITENV_ROOT})
  if(NOT GITENV_ROOT)
    if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/../gitenv/paths.cmake")
      get_filename_component(
          GITENV_ROOT
          "${CMAKE_CURRENT_LIST_DIR}/.."
          ABSOLUTE
      )
    endif()
  endif()
endif()

# Check and print customization variables
if(NOT POLLY_TOOLCHAIN_NAME)
  message(FATAL_ERROR "POLLY_TOOLCHAIN_NAME is empty")
endif()

if(NOT POLLY_TOOLCHAIN_PREFIX)
  message(FATAL_ERROR "POLLY_TOOLCHAIN_PREFIX is empty")
endif()

message("[polly] Used toolchain: ${POLLY_TOOLCHAIN_NAME}")

# Add extra 'find' cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/find")

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

if(GITENV_ROOT)
  message("GITENV_ROOT detected: ${GITENV_ROOT}")
  include("${GITENV_ROOT}/gitenv/paths.cmake")
endif()
