# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_BITCODE_)
  return()
else()
  set(POLLY_FLAGS_BITCODE_ 1)
endif()

set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE YES)

# It is not enough to set ENABLE_BITCODE to get binaries built with real bitcode information inside 
# We should set BITCODE_GENERATION_MODE to "bitcode" for release builds and to "marker" for debug builds 
# Only release builds usually need real bitcode for submission to Apple AppStore, so we'll save time on build
#
# https://medium.com/@heitorburger/static-libraries-frameworks-and-bitcode-6d8f784478a9

set(CMAKE_XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE[variant=Debug] "marker")
set(CMAKE_XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE "bitcode")

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "bitcode.3")

