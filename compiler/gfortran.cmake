# Copyright (c) 2017, NeroBurner
# All rights reserved.

if(DEFINED POLLY_COMPILER_Fortran_CMAKE)
  return()
else()
  set(POLLY_COMPILER_Fortran_CMAKE 1)
endif()

find_program(CMAKE_Fortran_COMPILER gfortran)

if(NOT CMAKE_Fortran_COMPILER)
  polly_status_print("gfortran not found")
else()
  set(
      CMAKE_Fortran_COMPILER
      "${CMAKE_Fortran_COMPILER}"
      CACHE
      STRING
      "Fortran compiler"
      FORCE
  )
endif()


