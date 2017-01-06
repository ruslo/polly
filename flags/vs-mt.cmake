# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_VS_MT_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_VS_MT_CMAKE_ 1)
endif()

foreach(_lang C CXX)
  set(CMAKE_${_lang}_FLAGS_DEBUG "/D_DEBUG /MTd /Zi /Ob0 /Od /RTC1" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_MINSIZEREL "/MT /O1 /Ob1 /DNDEBUG" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_RELEASE "/MT /O2 /Ob2 /DNDEBUG" CACHE STRING "" FORCE)
  set(CMAKE_${_lang}_FLAGS_RELWITHDEBINFO "/MT /Zi /O2 /Ob1 /DNDEBUG" CACHE STRING "" FORCE)
endforeach()
