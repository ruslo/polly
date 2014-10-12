# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(02-library)

add_library(foo "./foo.cpp")
install(TARGETS foo DESTINATION lib)

add_executable(simple "./main.cpp")
target_link_libraries(simple foo)

enable_testing()
add_test(SimpleTest simple)
