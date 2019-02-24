# Copyright (c) 2019, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_CLANG_TOOLS_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_CLANG_TOOLS_CMAKE_ 1)
endif()

include(polly_fatal_error)

if(NOT EXISTS "${CMAKE_CXX_COMPILER}")
  polly_fatal_error("CMAKE_CXX_COMPILER not found: ${CMAKE_CXX_COMPILER}")
endif()

get_filename_component(__llvm_dir "${CMAKE_CXX_COMPILER}" DIRECTORY)

set(CMAKE_AR "${__llvm_dir}/llvm-ar" CACHE FILEPATH "Archiver" FORCE)
set(CMAKE_LINKER "${__llvm_dir}/llvm-ld" CACHE FILEPATH "Linker" FORCE)
set(CMAKE_NM "${__llvm_dir}/llvm-nm" CACHE FILEPATH "nm" FORCE)
set(CMAKE_OBJDUMP "${__llvm_dir}/llvm-objdump" CACHE FILEPATH "objdump" FORCE)
set(CMAKE_RANLIB "${__llvm_dir}/llvm-ranlib" CACHE FILEPATH "ranlib" FORCE)

# "${__llvm_dir}/llvm-as" is not working
set(CMAKE_ASM_COMPILER "${CMAKE_C_COMPILER}" CACHE FILEPATH "Assembler")

unset(__llvm_dir)
