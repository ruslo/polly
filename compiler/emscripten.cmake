# Copyright (c) 2016, Alexandre Pretyman
# All rights reserved.

if(DEFINED POLLY_COMPILER_EMSCRIPTEN_CMAKE)
  return()
else()
  set(POLLY_COMPILER_EMSCRIPTEN_CMAKE 1)
endif()

include(polly_fatal_error)

string(COMPARE EQUAL "$ENV{EMSCRIPTEN}" "" _is_empty)
if(_is_empty)
  polly_fatal_error(
    "EMSCRIPTEN environment variable not set. Emscripten environment variables are in emsdk_env.sh"
  )
endif()

include("$ENV{EMSCRIPTEN}/cmake/Modules/Platform/Emscripten.cmake")
list(APPEND CMAKE_FIND_ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/emscripten")

