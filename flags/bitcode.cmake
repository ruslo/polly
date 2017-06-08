# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_BITCODE_)
  return()
else()
  set(POLLY_FLAGS_BITCODE_ 1)
endif()

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "bitcode")