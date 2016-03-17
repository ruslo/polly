# Copyright (c) 2013-2016, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(02-library)

add_library(foo "./foo.cpp")
install(TARGETS foo DESTINATION lib)

add_executable(simple "./main.cpp")
target_link_libraries(simple foo)

enable_testing()
if(IOS)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip iOS test")
elseif(ANDROID)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip Android test")
else()
  add_test(NAME SimpleTest COMMAND simple)
endif()
