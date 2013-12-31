# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(01-executable)

set(CMAKE_VERBOSE_MAKEFILE ON)

add_executable(simple "./main.cpp")

if(CUSTOM_LIBCXX_LIBRARY_LOCATION)
  set(Libcxx_USE_STATIC_LIBS YES)
  find_package(Libcxx REQUIRED)
  target_link_libraries(simple ${Libcxx_LIBRARIES}) # libc++ and libc++abi
  include_directories("${Libcxx_INCLUDE_DIRS}")
endif()

install(TARGETS simple DESTINATION "${PROJECT_SOURCE_DIR}/Install")

enable_testing()
add_test(testname simple)
