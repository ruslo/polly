# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

# Example of combined gtest project (native + ios)

cmake_minimum_required(VERSION 2.8.8)
project(01-gtest)
set(SUGAR_STATUS_PRINT TRUE)

# Note, you need to set environment variables:
# * SUGAR_ROOT:
#     root of sugar cmake library (https://github.com/ruslo/sugar)
# * GTEST_ROOT:
#     root of **install** gtest dir (https://github.com/ruslo/gtest)

include($ENV{SUGAR_ROOT}/cmake/Sugar)

include(sugar_add_gtest)
include(sugar_include)
include(sugar_set_xcode_ios_sdkroot)

find_package(GTest REQUIRED)

if("${CMAKE_OSX_SYSROOT}" STREQUAL "iphoneos")
  if(NOT XCODE_VERSION)
    sugar_fatal_error("Xcode only")
  endif()
  set(BUNDLE_TAG MACOSX_BUNDLE)
else()
  # iOS toolchain is not actually toolchain and not providing root.
  # You need to provide two roots and somehow switch between
  # them (iphoneos and iphonesimulator)
  find_package(Threads REQUIRED)
  set(BUNDLE_TAG "")
endif()

include_directories("${GTEST_INCLUDE_DIRS}")

sugar_include("./sources") # + UNITTEST_SOURCES

set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.example.sugar.GtestCombined")

add_executable(test_bin ${BUNDLE_TAG} ${UNITTEST_SOURCES})

target_link_libraries(test_bin ${GTEST_BOTH_LIBRARIES})
target_link_libraries(test_bin ${CMAKE_THREAD_LIBS_INIT})

if("${CMAKE_OSX_SYSROOT}" STREQUAL "iphoneos")
  set(PLIST_FILE "${SUGAR_ROOT}/examples/plist/ios/empty.plist.in")
  sugar_set_xcode_ios_sdkroot(test_bin ${PLIST_FILE})
endif()

enable_testing()
sugar_add_gtest(TestSample test_bin)
