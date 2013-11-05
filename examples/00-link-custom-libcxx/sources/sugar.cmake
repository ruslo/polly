# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED SOURCES_SUGAR_CMAKE)
  return()
else()
  set(SOURCES_SUGAR_CMAKE 1)
endif()

include(sugar_files)

sugar_files(
    SOURCES
    main.cpp
)
