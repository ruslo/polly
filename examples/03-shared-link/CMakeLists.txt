cmake_minimum_required(VERSION 2.8)
project(shared-link)

add_library(foo SHARED foo.cpp)
add_library(boo SHARED boo.cpp)

target_link_libraries(boo foo)

install(TARGETS boo DESTINATION "./lib")
