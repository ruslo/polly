### polly

[![Build Status](https://travis-ci.org/ruslo/polly.png?branch=master)](https://travis-ci.org/ruslo/polly)

Collection of CMake toolchain files

-----

Actually it's not a toolchain files, it's just files that included before first `CMakeLists.txt` and set some variables.
It's more like `initial-cache` cmake option, but `initial-cache` is not fit because it's quite limited
(`PROJECT_SOURCE_DIR` and generator variable is empty).
Each toolchain file set `POLLY_INSTALL_TAG` variable, which can be used for `CMAKE_INSTALL_PREFIX` modification.
For example if `PROJECT_SOURCE_DIR/_install/POLLY_INSTALL_TAG` is used for install, then
targets can coexist simultaneously:
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
Every toolchain `Foo` define two variables: `POLLY_TOOLCHAIN_NAME` and `POLLY_TOOLCHAIN_PREFIX`. First variable
will be printed while processing file:
```
Used toolchain: toolchain-foo-name
-- The CXX compiler identification is Clang 5.0.0
-- Check for working CXX compiler: /usr/bin/c++
Used toolchain: toolchain-foo-name
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
Used toolchain: toolchain-foo-name
-- Detecting CXX compiler ABI info - done
Used toolchain: toolchain-foo-name
-- Configuring done
-- Generating done
-- Build files have been written to: ...
```
Second variable can be used to define `CMAKE_INSTALL_PREFIX`:
```cmake
set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/_install/${POLLY_TOOLCHAIN_PREFIX}")
```

## Toolchains
### Common.cmake
* This is common module which is used by all modules and is loaded after name and prefix variables defined

Additionally:
* Try to detect [gitenv](https://github.com/ruslo/gitenv), if detected load file `gitenv/paths.cmake`
* Set variable `POLLY_INSTALL_PREFIX` to `_install/${POLLY_TOOLCHAIN_PREFIX}`
* Set variable `CMAKE_DEBUG_POSTFIX` to `d` (if it's not setted already)

### Default.cmake
| POLLY_TOOLCHAIN_NAME | POLLY_TOOLCHAIN_PREFIX |
|----------------------|------------------------|
| Default              | default                |
* No additional flags, just load `Common.cmake` 

### Libcxx.cmake
| POLLY_TOOLCHAIN_NAME | POLLY_TOOLCHAIN_PREFIX |
|----------------------|------------------------|
| libc++               | libcxx                 |
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`

### Libstdcxx.cmake
| POLLY_TOOLCHAIN_NAME | POLLY_TOOLCHAIN_PREFIX |
|----------------------|------------------------|
| libstdc++            | libstdcxx              |
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libstdc++`

### CustomLibcxx.cmake
| POLLY_TOOLCHAIN_NAME | POLLY_TOOLCHAIN_PREFIX |
|----------------------|------------------------|
| Custom libc++        | custom_libcxx          |
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`, `-nostdinc++`
* Add `CMAKE_EXE_LINKER_FLAGS`: `-nodefaultlibs`, `-lSystem`
* Set variable `CUSTOM_LIBCXX_LIBRARY_LOCATION` to `TRUE`

### iOS.cmake
| POLLY_TOOLCHAIN_NAME | POLLY_TOOLCHAIN_PREFIX |
|----------------------|------------------------|
| iOS                  | ios                    |
* Set `CMAKE_OSX_SYSROOT` to `iphoneos`
* *Note*
 * Xcode only
 * It's not `iphoneos` or `iphonesimulator` toolchain, this toolchain designed to be used with
[sugar_install_ios_library][1](or [sugar_install_library][2]) commands to create universal libraries.

[1]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_ios_library
[2]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_library

## Usage
Just define [CMAKE_TOOLCHAIN_FILE][3] variable:
```bash
> cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/polly/Libstdcxx.cmake .
Used toolchain: libstdc++
-- The CXX compiler identification is Clang 5.0.0
-- Check for working CXX compiler: /usr/bin/c++
Used toolchain: libstdc++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
Used toolchain: libstdc++
-- Detecting CXX compiler ABI info - done
-- Configuring done
-- Generating done
-- Build files have been written to: /.../_builds/make-debug
```
Take a look at make output, you must see `-stdlib=libstdc++` string:
```
> make VERBOSE=1
/usr/bin/c++ -std=c++11 -stdlib=libstdc++ -o CMakeFiles/.../main.cpp.o -c /.../main.cpp
```

*Note* that some typing time may be saved by defining `POLLY_ROOT` environment variable: `${POLLY_ROOT}/Libcxx.cmake`.
See this [script][4] with [integration][5]

[3]: http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
[4]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.sh
[5]: https://github.com/ruslo/configs
## Examples
