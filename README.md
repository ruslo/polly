### polly

| mac                                        | linux                                            |
|--------------------------------------------|--------------------------------------------------|
| [![Build Status][link_master]][link_polly] | [![Build Status][link_travis_linux]][link_polly] |

[link_master]: https://travis-ci.org/ruslo/polly.png?branch=master
[link_travis_linux]: https://travis-ci.org/ruslo/polly.png?branch=travis.linux
[link_polly]: https://travis-ci.org/ruslo/polly

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

Implementation of this idea can be found in [hunter](http://www.github.com/ruslo/hunter) package manager.

## Toolchains

* [default](https://github.com/ruslo/polly#default)
* [libcxx](https://github.com/ruslo/polly#libcxx)
* [clang_libstdcxx](https://github.com/ruslo/polly#clang_libstdcxx)
* [custom_libcxx](https://github.com/ruslo/polly#custom_libcxx)
* [gcc](https://github.com/ruslo/polly#gcc)
* [gcc48](https://github.com/ruslo/polly#gcc48)
* iOS
 * [ios](https://github.com/ruslo/polly#ios)
 * [ios-i386-armv7](https://github.com/ruslo/polly#ios-i386-armv7)
 * [ios-nocodesign](https://github.com/ruslo/polly#ios-nocodesign)
* Clang tools
 * [analyze](https://github.com/ruslo/polly#analyze)
 * [sanitize_address](https://github.com/ruslo/polly#sanitize_address)
 * [sanitize_leak](https://github.com/ruslo/polly#sanitize_leak)
 * [sanitize_memory](https://github.com/ruslo/polly#sanitize_memory)
 * [sanitize_thread](https://github.com/ruslo/polly#sanitize_thread)

## Toolchains
### utilities/polly_common.cmake
* This is common module which is used by all modules and is loaded after name and prefix variables defined

Additionally:
* Set `HUNTER_INSTALL_TAG` for [hunter](https://github.com/ruslo/hunter) support
* Set variable `CMAKE_DEBUG_POSTFIX` to `d` (if not already set)

### default
* Name: `Default`
* No additional flags, just load `polly_common.cmake`

### libcxx
* Name: `clang / LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`

### clang_libstdcxx
* Name: `clang / GNU Standard C++ Library (libstdc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libstdc++`

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
* Name: `iOS Universal (iphoneos + iphonesimulator) / c++11 support`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`
* Defaults to fix [try_compile](http://www.cmake.org/cmake/help/v2.8.12/cmake.html#command:try_compile) command:
 * Set `MACOSX_BUNDLE_GUI_IDENTIFIER` to `com.example`
 * Set `CMAKE_MACOSX_BUNDLE` to `YES`
 * Set `CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY` to `iPhone Developer`
* Set `CMAKE_OSX_SYSROOT` to `iphoneos`
* Set `IPHONEOS_ARCHS` to `armv7;armv7s;arm64`
* Set `IPHONESIMULATOR_ARCHS` to `i386;x86_64`
* Set `XCODE_DEVELOPER_ROOT` to `xcode-select -print-path` (e.g. `/Applications/Xcode.app/Contents/Developer/`)
* Try to detect highest ios version and save it to `IOS_SDK_VERSION` (e.g. `6.1`)
* Set `IPHONESIMULATOR_ROOT`/`IPHONEOS_ROOT` (e.g.
`/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer`)
* Set `IPHONESIMULATOR_SDK_ROOT`/`IPHONEOS_SDK_ROOT` using `IPHONE*_ROOT` and `IOS_SDK_VERSION`
(e.g. `/.../Xcode.app/.../iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk/`)
* Set `HUNTER_CMAKE_GENERATOR` to `Xcode` for [hunter](https://github.com/ruslo/hunter) support
* *Note*
 * Xcode only
 * It's not `iphoneos` or `iphonesimulator` toolchain, this toolchain designed to be used with
[patched](https://github.com/ruslo/CMake/releases) CMake version.

### ios-i386-armv7
* Name: `iOS Universal (iphoneos + iphonesimulator) / i386 / armv7 / c++11 support`
* Same as `ios`, but limited to `i386` and `armv7` architectures

### ios-nocodesign
* Name: `iOS Universal (iphoneos + iphonesimulator) / No code sign / c++11 support`
* Same as `ios`, but without `CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY`
* You need to define `XCODE_XCCONFIG_FILE` environment variable with path to
`$POLLY_ROOT/scripts/NoCodeSign.xcconfig` file (do not forget `export`!)
* Very helpful in server testing (no need to install developer sertificate)

### analyze
* Name `Clang static analyzer / c++11 support`
* Set `CMAKE_CXX_COMPILER` to wrapper [script](https://github.com/ruslo/polly/blob/master/scripts/clang-analyze.sh)
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-w`
* Note that for sake of easy integration script do double job:
 * analyze file (and fail on some warnings) 
 * compile file and produce usable binaries

### sanitize_address
* Name `Clang address sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=address`, `-g`
* Set `CMAKE_CXX_FLAGS_RELEASE` to `-O1`
* Set `HUNTER_DISABLE_SHARED_LIBS` to `YES`
* Check: out of bound, use after free, double free, invalid free
* http://clang.llvm.org/docs/AddressSanitizer.html
* Linux, Mac

### sanitize_leak
* Name `Clang memory leaks sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=leak`, `-g`
* http://clang.llvm.org/docs/LeakSanitizer.html
* Linux

### sanitize_memory
* Name `Clang memory sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=memory`, `-fsanitize-memory-track-origins`, `-g`
* http://clang.llvm.org/docs/MemorySanitizer.html
* Detect uninitialized reads
* Linux

### sanitize_thread
* Name `Clang thread sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=thread`, `-fPIE`, `-pie`, `-g`
* http://clang.llvm.org/docs/ThreadSanitizer.html
* Detect data races
* Linux

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

## Examples
See [examples](https://github.com/ruslo/polly/tree/master/examples).
Please [read](https://github.com/ruslo/0/wiki/CMake) coding style and
agreements before start looking through examples (may explain a lot).
Take a look at the [Travis](https://travis-ci.org/) config files:
[mac](https://github.com/ruslo/polly/blob/master/.travis.yml) and [linux](https://github.com/ruslo/polly/blob/travis.linux/.travis.yml),
it's quite self-explanatory.

[1]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_ios_library
[2]: https://github.com/ruslo/sugar/tree/master/cmake/core#sugar_install_library
[3]: http://www.cmake.org/Wiki/CMake_Cross_Compiling#The_toolchain_file
[4]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.sh
[5]: https://github.com/ruslo/configs
[6]: https://travis-ci.org/ruslo/polly/jobs/14486268#L939
