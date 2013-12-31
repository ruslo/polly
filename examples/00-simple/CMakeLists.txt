# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(00-simple)

set(CMAKE_VERBOSE_MAKEFILE ON)

message("tag: ${POLLY_TOOLCHAIN_TAG}")
message("name: ${POLLY_TOOLCHAIN_NAME}")

add_executable(simple "./main.cpp")
install(TARGETS simple DESTINATION "${PROJECT_SOURCE_DIR}/Install")
