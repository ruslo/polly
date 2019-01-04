### Polly

[![Join the chat at https://gitter.im/polly-cmake/Lobby](https://badges.gitter.im/polly-cmake/Lobby.svg)](https://gitter.im/polly-cmake/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Collection of CMake toolchain files and scripts.

| Linux/OSX                                       | Windows                                             |
|-------------------------------------------------|-----------------------------------------------------|
| [![Build Status][travis_status]][travis_builds] | [![Build Status][appveyor_status]][appveyor_builds] |

[travis_status]: https://travis-ci.org/ruslo/polly.svg?branch=master
[travis_builds]: https://travis-ci.org/ruslo/polly/builds

[appveyor_status]: https://ci.appveyor.com/api/projects/status/8x6thwc05mhvdxmo?svg=true
[appveyor_builds]: https://ci.appveyor.com/project/ruslo/polly/history

Every toolchain defines compiler/flags and two variables:
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
variable coincide with toolchain file name and *can* be used to define `CMAKE_INSTALL_PREFIX` like:
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

*Note*: This is a core idea of the tagged builds in [hunter](https://github.com/ruslo/hunter#tagged-builds) package manager.

## New documentation

* https://polly.readthedocs.io

## Toolchains

* [default](https://github.com/ruslo/polly/wiki/Toolchain-list#default)
* [libcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#libcxx)
* [clang-lto](https://github.com/ruslo/polly/wiki/Toolchain-list#clang-lto)
* [clang-libstdcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#clang-libstdcxx)
* [custom-libcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#custom-libcxx)
* [xcode](https://github.com/ruslo/polly/wiki/Toolchain-list#xcode)
* [osx-*](https://github.com/ruslo/polly/wiki/Toolchain-list#osx-a-b)
* [gcc](https://github.com/ruslo/polly/wiki/Toolchain-list#gcc)
* [gcc-4-8](https://github.com/ruslo/polly/wiki/Toolchain-list#gcc-4-8)
#### Android
 * [android-ndk-*](https://github.com/ruslo/polly/wiki/Toolchain-list#android-ndk-xxx)
#### iOS
 * [ios](https://github.com/ruslo/polly/wiki/Toolchain-list#ios)
 * [ios-i386-armv7](https://github.com/ruslo/polly/wiki/Toolchain-list#ios-i386-armv7)
 * [ios-nocodesign](https://github.com/ruslo/polly/wiki/Toolchain-list#ios-nocodesign)
#### Raspberry Pi
 * [raspberrypi2-cxx11](https://github.com/ruslo/polly/wiki/Toolchain-list#raspberrypi2-cxx11)
#### Clang tools
 * [analyze](https://github.com/ruslo/polly/wiki/Toolchain-list#analyze)
 * [sanitize-address](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-address)
 * [sanitize-leak](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-leak)
 * [sanitize-memory](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-memory)
 * [sanitize-thread](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-thread)
#### Windows
 * [vs-12-2013-win64](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013-win64)
 * [vs-12-2013](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013)
 * [vs-12-2013-xp](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013-xp)
 * [cygwin](https://github.com/ruslo/polly/wiki/Toolchain-list#cygwin)
 * [mingw](https://github.com/ruslo/polly/wiki/Toolchain-list#mingw)
 * [msys](https://github.com/ruslo/polly/wiki/Toolchain-list#msys)
 * [nmake-vs-12-2013-win64](https://github.com/ruslo/polly/wiki/Toolchain-list#nmake-vs-12-2013-win64)
 * [nmake-vs-12-2013](https://github.com/ruslo/polly/wiki/Toolchain-list#nmake-vs-12-2013)
#### Cross compiling
 * [linux-gcc-x64](https://github.com/ruslo/polly/wiki/Toolchain-list#linux-gcc-x64)

## Usage
Just define [CMAKE_TOOLCHAIN_FILE][3] variable:
```bash
> cmake -H. -B_builds/clang-libstdcxx -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/clang-libstdcxx.cmake -DCMAKE_VERBOSE_MAKEFILE=ON
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
> cmake --build _builds/clang_libstdcxx
/usr/bin/c++ -std=c++11 -stdlib=libstdc++ -o CMakeFiles/.../main.cpp.o -c /.../main.cpp
```

## polly.py

This is a python [script](https://github.com/ruslo/polly/tree/master/bin) that wrap cmake for you and automatically set:
* build directory for your toolchain. E.g. `_builds/xcode`, `_builds/libcxx-Debug`, `_builds/nmake-Release`
* local install directory. E.g. `_install/vs-12-2013-x64`, `_install/libcxx`
* start an IDE project (Xcode, Visual Studio) if option `--open` passed
* run `ctest` after the build done if option `--test` passed
* run `cpack` after the build done if option `--pack` passed
* create `OS X`/`iOS` framework if option `--framework` passed (can be used for broken iOS framework creation on CMake)

Example of usage (also see `polly.py --help`):
* build Debug Xcode project:
  * `polly.py --toolchain xcode --config Debug` (`_builds/xcode`)
* build and test Release Makefile project with `libcxx`:
  * `polly.py --toolchain libcxx --config Release --test` (`_builds/libcxx-Release`)
* install Debug Xcode project:
  * `polly.py --toolchain xcode --config Debug --install` (`_builds/xcode`, `_install/xcode`)

## Examples
See [examples](https://github.com/ruslo/polly/tree/master/examples).
Please [read](https://github.com/ruslo/0/wiki/CMake) coding style and
agreements before start looking through examples (may explain a lot).
Take a look at the [Travis](https://travis-ci.org/) config files:
[mac](https://github.com/ruslo/polly/blob/master/.travis.yml) and [linux](https://github.com/ruslo/polly/blob/linux/.travis.yml),
it's quite self-explanatory.

## Contributing

See [CONTRIBUTING.md](https://github.com/ruslo/polly/blob/master/CONTRIBUTING.md).

## Links

* [Hunter package manager](https://github.com/ruslo/hunter)
* [Installation on Jenkins](https://github.com/ruslo/polly/wiki/Jenkins)
* Travis example:
[Mac OS X](https://travis-ci.org/forexample/hunter-simple/builds/28155372) and 
[Linux](https://travis-ci.org/forexample/hunter-simple/builds/28154503)
* [Table of toolchains available for Travis CI/AppVeyor][7]
* [Travis, AppVeyor => GitHub deploy example](https://github.com/forexample/github-binary-release)

[1]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_ios_library
[2]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_library
[3]: http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
[4]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.sh
[5]: https://github.com/ruslo/configs
[6]: https://travis-ci.org/ruslo/polly/jobs/14486268#L939
[7]: https://github.com/ruslo/polly/wiki/Travis-CI-AppVeyor-support-table
[8]: https://github.com/ruslo/polly/blob/master/bin/polly.py
