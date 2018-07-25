# Copyright (c) 2018, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_VS_Z7_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_VS_Z7_CMAKE_ 1)
endif()

foreach(_lang C CXX)
  set(CMAKE_${_lang}_FLAGS_DEBUG "/D_DEBUG /MDd /Z7 /Ob0 /Od /RTC1" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_MINSIZEREL "/MD /O1 /Ob1 /DNDEBUG" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_RELEASE "/MD /O2 /Ob2 /DNDEBUG" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_RELWITHDEBINFO "/MD /Z7 /O2 /Ob1 /DNDEBUG" CACHE STRING "" FORCE)
endforeach()

list(APPEND HUNTER_TOOLCHAIN_UNDETECTABLE_ID "/Z7")
