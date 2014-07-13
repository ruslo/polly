### Polly

Collection of CMake toolchain files and scripts

| mac                                        | linux                                            |
|--------------------------------------------|--------------------------------------------------|
| [![Build Status][link_master]][link_polly] | [![Build Status][link_travis_linux]][link_polly] |

[link_master]: https://travis-ci.org/ruslo/polly.png?branch=master
[link_travis_linux]: https://travis-ci.org/ruslo/polly.png?branch=travis.linux
[link_polly]: https://travis-ci.org/ruslo/polly

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

*Note*: This is a core idea of the tagged builds in [hunter](https://github.com/ruslo/hunter#tagged-builds) package manager.

## Toolchains

* [default](https://github.com/ruslo/polly/wiki/Toolchain-list#default)
* [libcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#libcxx)
* [clang_libstdcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#clang_libstdcxx)
* [custom_libcxx](https://github.com/ruslo/polly/wiki/Toolchain-list#custom_libcxx)
* [xcode](https://github.com/ruslo/polly/wiki/Toolchain-list#xcode)
* [gcc](https://github.com/ruslo/polly/wiki/Toolchain-list#gcc)
* [gcc48](https://github.com/ruslo/polly/wiki/Toolchain-list#gcc48)
* iOS
 * [ios](https://github.com/ruslo/polly/wiki/Toolchain-list#ios)
 * [ios-i386-armv7](https://github.com/ruslo/polly/wiki/Toolchain-list#ios-i386-armv7)
 * [ios-nocodesign](https://github.com/ruslo/polly/wiki/Toolchain-list#ios-nocodesign)
* Clang tools
 * [analyze](https://github.com/ruslo/polly/wiki/Toolchain-list#analyze)
 * [sanitize_address](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize_address)
 * [sanitize_leak](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize_leak)
 * [sanitize_memory](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize_memory)
 * [sanitize_thread](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize_thread)
* Windows
 * [vs-12-2013-win64](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013-win64)
 * [vs-12-2013](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013)
 * [cygwin](https://github.com/ruslo/polly/wiki/Toolchain-list#cygwin)
 * [mingw](https://github.com/ruslo/polly/wiki/Toolchain-list#mingw)
 * [nmake-vs2013-x64](https://github.com/ruslo/polly/wiki/Toolchain-list#nmake-vs2013-x64)

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

## build.py

This is a python [script](https://github.com/ruslo/polly/tree/master/bin) that wrap cmake for you and automatically set:
* build directory for your toolchain. E.g. `_builds/xcode`, `_builds/libcxx-Debug`, `_builds/nmake-Release`
* local install directory. E.g. `_install/vs-12-2013-x64`, `_install/libcxx`
* start an IDE project (Xcode, Visual Studio) if option `--open` passed
* run `ctest` after the build done if option `--test` passed

Example of usage (also see `build.py --help`):
* build Debug Xcode project:
  * `build.py --toolchain xcode --config Debug` (`_builds/xcode`)
* build and test Release Makefile project with `libcxx`:
  * `build.py --toolchain libcxx --config Release --test` (`_builds/libcxx-Release`)
* install Debug Xcode project:
  * `build.py --toolchain xcode --config Debug --install` (`_builds/xcode`, `_install/xcode`)

*Note*: script expected that `POLLY_ROOT` environment variable is set.

## jenkins.py

This is an experimental [script](https://github.com/ruslo/polly/wiki/Jenkins) to run
matrix builds on [jenkins server](http://jenkins-ci.org). Read [wiki](https://github.com/ruslo/polly/wiki/Jenkins)
for details.

## Examples
See [examples](https://github.com/ruslo/polly/tree/master/examples).
Please [read](https://github.com/ruslo/0/wiki/CMake) coding style and
agreements before start looking through examples (may explain a lot).
Take a look at the [Travis](https://travis-ci.org/) config files:
[mac](https://github.com/ruslo/polly/blob/master/.travis.yml) and [linux](https://github.com/ruslo/polly/blob/travis.linux/.travis.yml),
it's quite self-explanatory.

## Links

* [Hunter package manager](https://github.com/ruslo/hunter)
* [Installation on Jenkins](https://github.com/ruslo/polly/wiki/Jenkins)
* Travis example:
[Mac OS X](https://travis-ci.org/forexample/hunter-simple/builds/28155372) and 
[Linux](https://travis-ci.org/forexample/hunter-simple/builds/28154503)
* [Table of toolchains available for Travis CI][7]

[1]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_ios_library
[2]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_library
[3]: http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
[4]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.sh
[5]: https://github.com/ruslo/configs
[6]: https://travis-ci.org/ruslo/polly/jobs/14486268#L939
[7]: https://github.com/ruslo/polly/wiki/Travis-support-table
[8]: https://github.com/ruslo/polly/blob/master/bin/build.py
