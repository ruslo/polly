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
* Android
 * [android-ndk-*](https://github.com/ruslo/polly/wiki/Toolchain-list#android-ndk-xxx)
* Raspberry Pi
 * [raspberrypi2-cxx11](https://github.com/ruslo/polly/wiki/Toolchain-list#raspberrypi2-cxx11)
* Clang tools
 * [analyze](https://github.com/ruslo/polly/wiki/Toolchain-list#analyze)
 * [sanitize-address](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-address)
 * [sanitize-leak](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-leak)
 * [sanitize-memory](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-memory)
 * [sanitize-thread](https://github.com/ruslo/polly/wiki/Toolchain-list#sanitize-thread)
* Windows
 * [vs-12-2013-win64](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013-win64)
 * [vs-12-2013](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013)
 * [vs-12-2013-xp](https://github.com/ruslo/polly/wiki/Toolchain-list#vs-12-2013-xp)
 * [cygwin](https://github.com/ruslo/polly/wiki/Toolchain-list#cygwin)
 * [mingw](https://github.com/ruslo/polly/wiki/Toolchain-list#mingw)
 * [msys](https://github.com/ruslo/polly/wiki/Toolchain-list#msys)
 * [nmake-vs-12-2013-win64](https://github.com/ruslo/polly/wiki/Toolchain-list#nmake-vs-12-2013-win64)
 * [nmake-vs-12-2013](https://github.com/ruslo/polly/wiki/Toolchain-list#nmake-vs-12-2013)
* Cross compiling
 * [linux-gcc-x64](https://github.com/ruslo/polly/wiki/Toolchain-list#linux-gcc-x64)

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

### clang-lto
* Name: `clang / LLVM Standard C++ Library (libc++) / c++11 support / LTO`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`, `-flto`

### clang-libstdcxx
* Name: `clang / GNU Standard C++ Library (libstdc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libstdc++`

### custom-libcxx
* Name: `clang / Custom LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`, `-nostdinc++`
* Add `CMAKE_EXE_LINKER_FLAGS`: `-nodefaultlibs`, `-lSystem`
* Set variable [CUSTOM_LIBCXX_LIBRARY_LOCATION](https://github.com/ruslo/polly/wiki/Used-variables#custom_libcxx_library_location) to `TRUE`
* See [wiki](https://github.com/ruslo/polly/wiki/Building-libcxx) for more info

### xcode
* Name: `Xcode / LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `xcrun --find clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`
* Set `HUNTER_CMAKE_GENERATOR` to `Xcode` for [hunter](https://github.com/ruslo/hunter) support
* Note
 * Xcode only
 * Xcode ignores `CMAKE_C{XX}_COMPILER` variable (This is the reason why toolchain exists)

### osx-A-B
* Name: `Xcode (OS X A.B) / LLVM Standard C++ Library (libc++) / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `xcrun --find clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-stdlib=libc++`
* Set `CMAKE_OSX_DEPLOYMENT_TARGET` to `A.B`
* Set `CMAKE_OSX_SYSROOT` to `.../Platforms/MacOSX.platform/Developer/SDKs/MacOSXA.B.sdk`
* Environment variables `OSX_A_B_DEVELOPER_DIR` can be used to switch between Xcode versions (see [ios](https://github.com/ruslo/polly/wiki/Toolchain-list#ios) toolchain)
* See `xcode` toolchain notes

### gcc
* Name: `gcc / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `gcc`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`

### gcc-4-8
* Same as `gcc`, but with `gcc 4.8`. (See [usage](https://github.com/travis-ci-tester/travis-test-gcc-cxx-11))

### android-ndk-xxx
* Name: `Android NDK xxx / c++11 support`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`
* Include [android-toolchain](https://github.com/taka-no-me/android-cmake)
* Check environment variable `ANDROID_NDK_xxx`. If this variable is defined set CMake `ANDROID_NDK`
* [Enabling On-device Developer Options](https://developer.android.com/studio/run/device.html)


### raspberrypi2-cxx11
* Name: `RaspberryPi 2 Cross Compile / C++11`
* You need to define next environment variables:
 * `RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH` - absolute path of the "bin" directory for the toolchain
 * `RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX` - triplet of the toolchain (ex: arm-linux-gnueabihf)
 * `RASPBERRYPI_CROSS_COMPILE_SYSROOT` - sysroot

### analyze
* Name `Clang static analyzer / c++11 support`
* Set `CMAKE_CXX_COMPILER` to wrapper [script](https://github.com/ruslo/polly/blob/master/scripts/clang-analyze.sh)
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-w`
* Note that for sake of easy integration script do double job:
 * analyze file (and fail on some warnings) 
 * compile file and produce usable binaries

### sanitize-address
* Name `Clang address sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=address`, `-g`
* Set `CMAKE_CXX_FLAGS_RELEASE` to `-O1`
* Check: out of bound, use after free, double free, invalid free
* http://clang.llvm.org/docs/AddressSanitizer.html
* Linux, Mac

### sanitize-leak
* Name `Clang memory leaks sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=leak`, `-g`
* http://clang.llvm.org/docs/LeakSanitizer.html
* Linux

### sanitize-memory
* Name `Clang memory sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=memory`, `-fsanitize-memory-track-origins`, `-g`
* http://clang.llvm.org/docs/MemorySanitizer.html
* Detect uninitialized reads
* Linux

### sanitize-thread
* Name `Clang thread sanitizer / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `clang`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`, `-fsanitize=thread`, `-fPIE`, `-pie`, `-g`
* http://clang.llvm.org/docs/ThreadSanitizer.html
* Detect data races
* Linux

### vs-12-2013-win64

* Name `Visual Studio 12 2013 Win64`

### vs-12-2013

* Name `Visual Studio 12 2013`

### vs-12-2013-xp

* Name `Visual Studio 12 2013`
* Set vs-toolset to `vs120_xp` (i.e. add option '-T vs120_xp')

### cygwin

* Name `cygwin / gcc / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `gcc`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11` `-U__STRICT_ANSI__`

### mingw

* Name `mingw / gcc / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `gcc`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`
* *Note*: `mingw32-make.exe` must be in `PATH` (or `MINGW_PATH` for `build.py` script)

### msys

* Name `MSYS / gcc / c++11 support`
* Set `CMAKE_C{XX}_COMPILER` to `gcc`
* Add `CMAKE_CXX_FLAGS`: `-std=c++11`
* *Note*: `make.exe` must be in `PATH` (or `MSYS_PATH` for `build.py` script)

### nmake-vs-12-2013-win64

* Name `NMake / Visual Studio 2013 / x64`

### nmake-vs-12-2013

* Name `NMake / Visual Studio 2013 / x86`

### linux-gcc-x64

* Name `Linux / gcc / x86_64 / c++11 support`
* `x86_64-pc-linux-gcc` should be in PATH
* Tested: http://crossgcc.rts-software.org/doku.php?id=compiling_for_linux