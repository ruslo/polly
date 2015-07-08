# Copyright (c) 2015 Alexandre Pretyman
# All rights reserved.
#
# ------------------------------------------------------------------------------
#  GCC Based Cross Compiler CMake toolchain file
#
#  Variables:
#   CROSS_COMPILE_TOOLCHAIN_PATH=/path/to/toolchain/bin
#     
#   CROSS_COMPILE_TOOLCHAIN_PREFIX=arm-unknown-linux-gnueabihf
#   CROSS_COMPILE_SYSROOT=/path/to/sysroot [optional]
# ------------------------------------------------------------------------------

cmake_minimum_required( VERSION 2.8 )

if(DEFINED POLLY_COMPILER_GCC_CROSS_COMPILE)
	return()
else()
	set(POLLY_COMPILER_GCC_CROSS_COMPILE TRUE)
endif()

if( CMAKE_TOOLCHAIN_FILE )
 # touch toolchain variable to suppress "unused variable" warning
endif()

#Check for if sysroot exists, optional, since it could be hardcoded in the compiler
string(COMPARE NOTEQUAL "${CROSS_COMPILE_SYSROOT}" "" _has_sysroot)
if (_has_sysroot)
	set(SYSROOT_COMPILE_FLAG "--sysroot=${CROSS_COMPILE_SYSROOT}")
	set(CMAKE_C_FLAGS        "${CMAKE_C_FLAGS} ${SYSROOT_COMPILE_FLAG}")
	set(CMAKE_CXX_FLAGS      "${CMAKE_CXX_FLAGS} ${SYSROOT_COMPILE_FLAG}")
endif()

# The (...)_PREFIX variable name refers to the Cross Compiler Triplet
#set(TOOLCHAIN_PATH_AND_PREFIX ${CROSS_COMPILE_PATH}/${CROSS_COMPILE_TOOLCHAIN_TRIPLET})
set(CMAKE_C_COMPILER     "${TOOLCHAIN_PATH_AND_PREFIX}-gcc"     CACHE PATH "C compiler" )
set(CMAKE_CXX_COMPILER   "${TOOLCHAIN_PATH_AND_PREFIX}-g++"     CACHE PATH "C++ compiler" )
set(CMAKE_ASM_COMPILER   "${TOOLCHAIN_PATH_AND_PREFIX}-as"      CACHE PATH "Assembler" )
set(CMAKE_C_PREPROCESSOR "${TOOLCHAIN_PATH_AND_PREFIX}-cpp"     CACHE PATH "Preprocessor" )
set(CMAKE_STRIP          "${TOOLCHAIN_PATH_AND_PREFIX}-strip"   CACHE PATH "strip" )
if( EXISTS "${TOOLCHAIN_PATH_AND_PREFIX}-gcc-ar" )
	# Prefer gcc-ar over binutils ar: https://gcc.gnu.org/wiki/LinkTimeOptimizationFAQ
	set(CMAKE_AR           "${TOOLCHAIN_PATH_AND_PREFIX}-gcc-ar"  CACHE PATH "Archiver" )
else()
 	set(CMAKE_AR           "${TOOLCHAIN_PATH_AND_PREFIX}-ar"      CACHE PATH "Archiver" )
endif()
set(CMAKE_LINKER         "${TOOLCHAIN_PATH_AND_PREFIX}-ld"      CACHE PATH "Linker" )
set(CMAKE_NM             "${TOOLCHAIN_PATH_AND_PREFIX}-nm"      CACHE PATH "nm" )
set(CMAKE_OBJCOPY        "${TOOLCHAIN_PATH_AND_PREFIX}-objcopy" CACHE PATH "objcopy" )
set(CMAKE_OBJDUMP        "${TOOLCHAIN_PATH_AND_PREFIX}-objdump" CACHE PATH "objdump" )
set(CMAKE_RANLIB         "${TOOLCHAIN_PATH_AND_PREFIX}-ranlib"  CACHE PATH "ranlib" )

#set( CMAKE_C_PLATFORM_ID Linux )
#set( CMAKE_C_COMPILER_ID GNU)
#set( CMAKE_C_SIZEOF_DATA_PTR 4 )
#set( CMAKE_C_HAS_ISYSROOT 1 )
#set( CMAKE_C_COMPILER_ABI ELF )
#set( CMAKE_CXX_COMPILER_ID GNU)
#set( CMAKE_CXX_PLATFORM_ID Linux)
#set( CMAKE_CXX_SIZEOF_DATA_PTR 4)
#set( CMAKE_CXX_HAS_ISYSROOT 1)
#set( CMAKE_CXX_COMPILER_ABI ELF)
#set( CMAKE_CXX_SOURCE_FILE_EXTENSIONS cc cp cxx cpp CPP c++ C )
## force ASM compiler (required for CMake < 2.8.5)
#set( CMAKE_ASM_COMPILER_ID_RUN TRUE )
#set( CMAKE_ASM_COMPILER_ID GNU )
#set( CMAKE_ASM_COMPILER_WORKS TRUE )
#set( CMAKE_ASM_COMPILER_FORCED TRUE )
#set( CMAKE_COMPILER_IS_GNUASM 1)
#set( CMAKE_ASM_SOURCE_FILE_EXTENSIONS s S asm )


