# Copyright (c) 2015, Ruslan Baratov, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_FLAGS_FPIC_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_FPIC_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _not_android)

# TODO: test other platfroms, CMAKE_CXX_FLAGS_INIT should work for all
if(_not_android)
  polly_add_cache_flag(CMAKE_CXX_FLAGS "-fPIC")
  polly_add_cache_flag(CMAKE_C_FLAGS "-fPIC")
  polly_add_cache_flag(CMAKE_Fortran_FLAGS "-fPIC")
else()
  polly_add_cache_flag(CMAKE_CXX_FLAGS_INIT "-fPIC")
  polly_add_cache_flag(CMAKE_C_FLAGS_INIT "-fPIC")
  polly_add_cache_flag(CMAKE_Fortran_FLAGS_INIT "-fPIC")
endif()

set(
    CMAKE_POSITION_INDEPENDENT_CODE
    TRUE
    CACHE
    BOOL
    "Position independent code"
    FORCE
)

# Linux, GCC 7.3.0 same results with and without '-fPIC' flag for code:
#
#  #include <iostream>
#  int main() {
#  #if defined(__PIC__)
#    std::cout << "PIC: " << __PIC__ << std::endl;
#  #else
#    std::cout << "PIC not defined" << std::endl;
#  #endif
#  }
list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "pic")
