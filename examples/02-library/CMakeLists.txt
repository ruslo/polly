# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 2.8.8)
project(02-library)

include("$ENV{SUGAR_ROOT}/cmake/Sugar")
include(sugar_install_library)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/Install/${POLLY_TOOLCHAIN_TAG}")

add_library(simple "./foo.cpp")
sugar_install_library(TARGETS simple DESTINATION "./lib")

if(CUSTOM_LIBCXX_LIBRARY_LOCATION)
  set(Libcxx_USE_STATIC_LIBS YES)
  find_package(Libcxx REQUIRED)
  target_link_libraries(simple ${Libcxx_LIBRARIES}) # libc++ and libc++abi
  include_directories("${Libcxx_INCLUDE_DIRS}")
endif()
