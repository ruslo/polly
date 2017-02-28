# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_UTILITIES_POLLY_IOS_DEVELOPMENT_TEAM_CMAKE_)
  return()
else()
  set(POLLY_UTILITIES_POLLY_IOS_DEVELOPMENT_TEAM_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/polly_fatal_error.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/polly_status_debug.cmake")


if(DEFINED ENV{POLLY_IOS_DEVELOPMENT_TEAM})
    set(POLLY_IOS_DEVELOPMENT_TEAM "$ENV{POLLY_IOS_DEVELOPMENT_TEAM}" CACHE STRING "" FORCE)
endif()
string(COMPARE EQUAL "${POLLY_IOS_DEVELOPMENT_TEAM}" "" _is_empty)
if(_is_empty)
  polly_fatal_error(
      "Environment variable POLLY_IOS_DEVELOPMENT_TEAM is empty"
      " (see details: http://polly.readthedocs.io/en/latest/toolchains/ios/errors/polly_ios_development_team.html)"
  )
endif()

set(
    CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM
    "${POLLY_IOS_DEVELOPMENT_TEAM}"
)

polly_status_debug(
    "Using iOS development team id: ${CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM}"
)
