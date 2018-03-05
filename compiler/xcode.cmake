# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_XCODE_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_XCODE_CMAKE_ 1)
endif()

include(polly_fatal_error)

string(COMPARE EQUAL "${POLLY_XCODE_COMPILER}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("Please set POLLY_XCODE_COMPILER")
endif()

set(_cmd xcrun --find "${POLLY_XCODE_COMPILER}")

execute_process(
    COMMAND
    ${_cmd}
    OUTPUT_VARIABLE _compiler_path
    RESULT_VARIABLE _result
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(NOT _result EQUAL 0)
  polly_fatal_error("Command failed: ${_cmd}")
endif()

set(CMAKE_XCODE_ATTRIBUTE_CC "${_compiler_path}")

polly_status_debug("Compiler: ${_compiler_path}")
