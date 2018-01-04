# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_BITCODE_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_BITCODE_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

# Enable Bitcode support that are built using Xcode.
set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE YES)

# It is not enough to set ENABLE_BITCODE to get binaries built with real bitcode information inside
# We should set BITCODE_GENERATION_MODE to "bitcode" for release builds and to "marker" for debug builds
# Only release builds usually need real bitcode for submission to Apple AppStore, so we'll save time on build.
#
# See more at https://medium.com/@heitorburger/static-libraries-frameworks-and-bitcode-6d8f784478a9

set(CMAKE_XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE[variant=Debug] "marker")
set(CMAKE_XCODE_ATTRIBUTE_BITCODE_GENERATION_MODE "bitcode")

# Define flags Xcode may pass to other projects.
set(CMAKE_XCODE_ATTRIBUTE_OTHER_CFLAGS[variant=Debug] "-fembed-bitcode-marker")
set(CMAKE_XCODE_ATTRIBUTE_OTHER_CFLAGS "-fembed-bitcode")

# Define flags for projects that do not use Xcode.
polly_add_cache_flag(CMAKE_CXX_FLAGS_DEBUG "-fembed-bitcode-marker")
polly_add_cache_flag(CMAKE_CXX_FLAGS_RELEASE "-fembed-bitcode")
polly_add_cache_flag(CMAKE_C_FLAGS_DEBUG "-fembed-bitcode-marker")
polly_add_cache_flag(CMAKE_C_FLAGS_RELEASE "-fembed-bitcode")

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "bitcode")
