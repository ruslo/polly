# Copyright (c) 2013-2016, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(03-shared-link)

include(GenerateExportHeader)

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
if(IOS)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip iOS test")
elseif(ANDROID)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip Android test")
else()
  add_test(NAME SimpleTest COMMAND simple)
endif()
