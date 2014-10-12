# Copyright (c) 2013-2014, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(03-shared-link)

add_library(foo SHARED foo.cpp)
add_library(boo SHARED boo.cpp)

target_link_libraries(boo foo)

install(TARGETS boo DESTINATION lib)

add_executable(simple "./main.cpp")
target_link_libraries(simple boo)

enable_testing()
add_test(SimpleTest simple)
