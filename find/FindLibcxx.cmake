# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(NOT Libcxx_FIND_QUIETLY)
  # TODO ???
endif()

if(NOT Libcxx_FIND_REQUIRED)
  # TODO ???
endif()

if(NOT LIBCXX_ROOT)
  set(LIBCXX_ROOT $ENV{LIBCXX_ROOT})
endif()

include(polly_fatal_error)
include(polly_status_print)

if(NOT LIBCXX_ROOT)
  polly_fatal_error(
      "LIBCXX_ROOT not found. Please set cmake or environment variable"
  )
endif()

if(Libcxx_FOUND)
  return()
endif()

polly_status_print("Libcxx root: ${LIBCXX_ROOT}")

set(
    Libcxx_INCLUDE_DIRS
    "${LIBCXX_ROOT}/include/c++/v1"
)

set(_find_libcxx_save_find_suffixes ${CMAKE_FIND_LIBRARY_SUFFIXES})
if(Libcxx_USE_STATIC_LIBS)
  polly_status_print("Libcxx static libraries: ON")
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_STATIC_LIBRARY_SUFFIX})
else()
  polly_status_print("Libcxx static libraries: OFF")
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_SHARED_LIBRARY_SUFFIX})
endif()

set(_find_libcxx_install_path "${LIBCXX_ROOT}/lib")

if(CMAKE_DEBUG_POSTFIX)
  set(_find_libcxx_debug_name c++${CMAKE_DEBUG_POSTFIX})
else()
  polly_status_print("CMAKE_DEBUG_POSTFIX is empty, no Debug library variant")
  set(_find_libcxx_debug_name c++)
endif()

find_library(
    Libcxx_LIBRARY_DEBUG
    ${_find_libcxx_debug_name}
    PATH
    "${_find_libcxx_install_path}"
    NO_DEFAULT_PATH
)

if(NOT Libcxx_LIBRARY_DEBUG)
  polly_fatal_error(
      "Libcxx library(debug): ${_find_libcxx_debug_name}, "
      "not found in: ${_find_libcxx_install_path}"
  )
endif()

find_library(
    Libcxx_LIBRARY_RELEASE
    c++
    PATH
    "${_find_libcxx_install_path}"
    NO_DEFAULT_PATH
)

if(NOT Libcxx_LIBRARY_RELEASE)
  polly_fatal_error(
      "Libcxx library(release) not found in: ${_find_libcxx_install_path}"
  )
endif()

set(
    Libcxx_LIBRARY
    debug
    "${Libcxx_LIBRARY_DEBUG}"
    optimized
    "${Libcxx_LIBRARY_RELEASE}"
)

# revert cmake suffixes
set(CMAKE_FIND_LIBRARY_SUFFIXES ${_find_libcxx_save_find_suffixes})

find_library(LibcxxAbi_LIBRARY c++abi)
if(NOT LibcxxAbi_LIBRARY)
  polly_fatal_error("libc++abi not found")
endif()

set(Libcxx_LIBRARIES ${Libcxx_LIBRARY} ${LibcxxAbi_LIBRARY})

set(Libcxx_FOUND TRUE)
