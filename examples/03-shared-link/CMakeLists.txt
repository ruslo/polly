cmake_minimum_required(VERSION 2.8)
project(shared-link)

add_library(foo SHARED foo.cpp)
add_library(boo SHARED boo.cpp)

target_link_libraries(boo foo)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/Install/${POLLY_TOOLCHAIN_TAG})

install(TARGETS boo DESTINATION "./lib")
