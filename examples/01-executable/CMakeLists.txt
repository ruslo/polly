# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(01-executable)

add_executable(simple "./main.cpp")

install(TARGETS simple DESTINATION bin)

enable_testing()
add_test(SimpleTest simple)
