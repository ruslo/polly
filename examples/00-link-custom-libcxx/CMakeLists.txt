# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

# Example of linking with custom builded libcxx

cmake_minimum_required(VERSION 2.8.8)
project(00-link-custom-libcxx CXX)
set(SUGAR_STATUS_PRINT TRUE) # print process messages
set(SUGAR_STATUS_DEBUG FALSE) # print ALL process messages

include($ENV{SUGAR_ROOT}/cmake/Sugar)

include(sugar_include)
sugar_include("./sources")
   # update all sources variables (load sugar.cmake files)

add_subdirectory("./sources")
   # create targets (load CMakeLists.txt)
