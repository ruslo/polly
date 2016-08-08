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
    "EMSCRIPTEN environment variable not set. Set up your Emscripten environment variables with emsdk_env.sh"
  )
endif()


include("${CMAKE_CURRENT_LIST_DIR}/emscripten.toolchain.cmake")

