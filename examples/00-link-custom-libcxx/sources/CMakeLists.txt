# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

add_executable(simple_bin ${SOURCES})

if(CUSTOM_LIBCXX_LIBRARY_LOCATION)
  find_package(Libcxx REQUIRED)
  target_link_libraries(simple_bin ${Libcxx_LIBRARIES}) # libc++ and libc++abi
  include_directories(${Libcxx_INCLUDE_DIRS})
endif()
