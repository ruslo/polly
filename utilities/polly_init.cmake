# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_UTILITIES_POLLY_INIT_CMAKE_)
  return()
else()
  set(POLLY_UTILITIES_POLLY_INIT_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/polly_fatal_error.cmake")

macro(polly_init name generator)
  set(POLLY_TOOLCHAIN_NAME "${name}")
  get_filename_component(
      POLLY_TOOLCHAIN_TAG "${CMAKE_CURRENT_LIST_FILE}" NAME_WE
  )

  string(COMPARE EQUAL "${CMAKE_GENERATOR}" "${generator}" _polly_correct)
  if(NOT _polly_correct)
    polly_fatal_error(
        "Please change generator to: ${generator}\n"
        "(Current generator: ${CMAKE_GENERATOR})"
    )
  endif()
  set(HUNTER_CMAKE_GENERATOR "${generator}")
endmacro()
