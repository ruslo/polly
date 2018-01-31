# Copyright (c) 2013-2016, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(01-executable)

add_executable(simple "./main.cpp")

install(TARGETS simple DESTINATION bin)

enable_testing()
if(IOS)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip iOS test")
elseif(ANDROID)
  add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip Android test")
else()
  add_test(NAME SimpleTest COMMAND simple)
endif()
