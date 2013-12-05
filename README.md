### polly

[![Build Status](https://travis-ci.org/ruslo/polly.png?branch=master)](https://travis-ci.org/ruslo/polly)

Collection of CMake toolchain files

-----

Actually it's not a toolchain files, it's just files that included before first `CMakeLists.txt` and set some variables.
It's more like `initial-cache` cmake option, but `initial-cache` is not fit because it's quite limited
(`PROJECT_SOURCE_DIR` and generator variable is empty).

Every toolchain defines two variables:
* `POLLY_TOOLCHAIN_NAME`
* `POLLY_TOOLCHAIN_TAG`

[First](https://github.com/ruslo/polly/wiki/Used-variables#polly_toolchain_name)
variable will be printed while processing file:
```
-- [polly] Used toolchain: Name of toolchain A
-- The CXX compiler identification is Clang 5.0.0
-- Check for working CXX compiler: /usr/bin/c++
-- [polly] Used toolchain: Name of toolchain A
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- [polly] Used toolchain: Name of toolchain A
-- Detecting CXX compiler ABI info - done
-- [polly] Used toolchain: Name of toolchain A
-- Configuring done
-- Generating done
-- Build files have been written to: ...
```
[Second](https://github.com/ruslo/polly/wiki/Used-variables#polly_toolchain_tag)
variable coincide with toolchain file name and *can* be used to define `CMAKE_INSTALL_PREFIX`:
```cmake
set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/_install/${POLLY_TOOLCHAIN_TAG}")
```
In this case targets can coexist simultaneously:
```
 - Project\ -
            - CMakeLists.txt
            - sources\
            - documentation\
            - ...
            - _install\ -
                        - toolchain-A\
                        - toolchain-B\
                        - toolchain-C\
                        - ...
```



## Toolchains
### utilities/common.cmake
* This is common module which is used by all modules and is loaded after name and prefix variables defined

Additionally:
* Set `HUNTER_INSTALL_TAG` for [hunter](https://github.com/ruslo/hunter) support
* Set variable `CMAKE_DEBUG_POSTFIX` to `d` (if not already set)

### default
* Name: `Default`
* No additional flags, just load `common.cmake`

### libcxx
* Name: `clang / LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`

### clang_libstdcxx
* Name: `clang / GNU Standard C++ Library (libstdc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libstdc++`

### clang32_libstdcxx
* Same as `clang_libstdcxx`, but with `clang 3.2`. (See [usage](https://github.com/travis-ci-tester/travis-test-clang-cxx-11))

### custom_libcxx
* Name: `clang / Custom LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`, `-nostdinc++`
* Add `CMAKE_EXE_LINKER_FLAGS`: `-nodefaultlibs`, `-lSystem`
* Set variable [CUSTOM_LIBCXX_LIBRARY_LOCATION](https://github.com/ruslo/polly/wiki/Used-variables#custom_libcxx_library_location) to `TRUE`
* See [wiki](https://github.com/ruslo/polly/wiki/Building-libcxx) for more info

### gcc
* Name: `gcc / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `gcc`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`
 
### gcc48
* Same as `gcc`, but with `gcc 4.8`. (See [usage](https://github.com/travis-ci-tester/travis-test-gcc-cxx-11))

### ios
* Name: `iOS Universal (iphoneos + iphonesimulator)`
* Set `CMAKE_OSX_SYSROOT` to `iphoneos`
* Set `IOS_ARCHS` to `armv7;armv7s` (if not already set)
* Set `XCODE_DEVELOPER_ROOT` to `xcode-select -print-path`
* Try to detect highest ios version and save it to `IOS_SDK_VERSION` (if not already set)
* Set `HUNTER_CMAKE_GENERATOR` to `Xcode` for [hunter](https://github.com/ruslo/hunter) support
* *Note*
 * Xcode only
 * It's not `iphoneos` or `iphonesimulator` toolchain, this toolchain designed to be used with
[sugar_install_ios_library][1](or [sugar_install_library][2]) command to create universal libraries.

[1]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_ios_library
[2]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_library

## Usage
Just define [CMAKE_TOOLCHAIN_FILE][3] variable:
```bash
> cmake -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/clang_libstdcxx.cmake .
-- [polly] Used toolchain: clang / GNU Standard C++ Library (libstdc++) / c++11 support
-- The CXX compiler identification is Clang 5.0.0
-- Check for working CXX compiler: /usr/bin/c++
-- [polly] Used toolchain: clang / GNU Standard C++ Library (libstdc++) / c++11 support
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- [polly] Used toolchain: clang / GNU Standard C++ Library (libstdc++) / c++11 support
-- Detecting CXX compiler ABI info - done
-- Configuring done
-- Generating done
-- Build files have been written to: /.../_builds/make-debug
```
Take a look at make output, you must [see][6] `-stdlib=libstdc++` string:
```
> make VERBOSE=1
/usr/bin/c++ -std=c++11 -stdlib=libstdc++ -o CMakeFiles/.../main.cpp.o -c /.../main.cpp
```

*Note* that some typing time may be saved by defining `POLLY_ROOT` environment variable: `${POLLY_ROOT}/libcxx.cmake`.
See this [script][4] with [integration][5]

[3]: http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
[4]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.sh
[5]: https://github.com/ruslo/configs
[6]: https://travis-ci.org/ruslo/polly/jobs/14486268#L939
## Examples
See [examples](https://github.com/ruslo/polly/tree/master/examples).
Please [read](https://github.com/ruslo/0/wiki/CMake) coding style and
agreements before start looking through examples (may explain a lot).
Take a look at the [Travis](https://travis-ci.org/) config
[file](https://github.com/ruslo/polly/blob/master/.travis.yml),
it's quite self-explanatory.
