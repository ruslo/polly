# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.2)
project(04-framework)

option(BUILD_SHARED_LIBS "..." ON)

add_library(foo foo.cpp)

install(TARGETS foo DESTINATION lib)

set_target_properties(
    foo
    PROPERTIES
    FRAMEWORK TRUE
)

enable_testing()
add_test(NAME SimpleTest COMMAND "${CMAKE_COMMAND}" -E echo "Skip test")
