### polly

Collection of CMake toolchain files

-----

Actually it's not a toolchain files, it's just files that included before first `CMakeLists.txt` and set some variables.
It's more like `initial-cache` cmake option, but `initial-cache` is not fit because `PROJECT_SOURCE_DIR` is empty.
Each toolchain file set `CMAKE_INSTALL_PREFIX` variable to point to separate directory inside `PROJECT_SOURCE_DIR/_install`,
so you can install targets simultaneously:
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
Second variable will be used to define `CMAKE_INSTALL_PREFIX`:
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

## Examples
