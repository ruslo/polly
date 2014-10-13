# Copyright (c) 2013-2014, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(03-shared-link)

include(GenerateExportHeader)

string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" is_ios)
if(is_ios)
  # Phony install to allow running test `cmake --build _builds --target install`
  install(FILES foo.cpp DESTINATION lib)

  message("Skip test (shared libraries disabled on iOS)")
  return()
endif()

add_library(foo SHARED foo.cpp)
add_library(boo SHARED boo.cpp)

generate_export_header(foo)
generate_export_header(boo)

include_directories("${CMAKE_CURRENT_BINARY_DIR}")

target_link_libraries(boo foo)

install(TARGETS boo DESTINATION lib)

add_executable(simple "./main.cpp")
target_link_libraries(simple boo)

enable_testing()
add_test(SimpleTest simple)
