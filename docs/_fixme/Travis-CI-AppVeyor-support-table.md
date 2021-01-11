* https://github.com/travis-ci-tester/toolchain-table

### Mac OS X (Travis CI)
  name             | support | notes
-------------------|---------|------
  default          | **YES** |
  libcxx           | **YES** |
  clang-libstdcxx  | **YES** |
  custom-libcxx    | *no*    | Libcxx installation needed (TODO hunter?)
  xcode            | **YES** | (excluded, same as osx-10-9)
  osx-10-11         | **YES** |
  gcc              | **YES** | (excluded, [same as libcxx](https://github.com/travis-ci-tester/travis-test-osx-clang-gcc-same))
  gcc48            | *no*    | This is linux workaround toolchain
  ios              | *no*    | need to install developer sertificate (use `ios-nocodesign`)
  ios-i386-armv7   | *no*    | need to install developer sertificate (use `ios-nocodesign`)
  ios-nocodesign-9-3| **YES** |
  android-...      | **YES** |
  analyze          | **YES** |
  sanitize-address | *no*    | https://github.com/travis-ci-tester/travis-test-mac-clang-address-sanitizer (Need to build clang from sources)
  sanitize-leak    | *no*    | [linux only](http://clang.llvm.org/docs/LeakSanitizer.html)
  sanitize-memory  | *no*    | [linux only](http://clang.llvm.org/docs/MemorySanitizer.html)
  sanitize-thread  | *no*    | [linux only](http://clang.llvm.org/docs/ThreadSanitizer.html)

### Linux (Travis CI)

  name             | support | notes
-------------------|---------|------
  default          | **YES** |
  libcxx           | *no*    | https://github.com/travis-ci-tester/travis-test-clang-with-libcxx
  clang-libstdcxx  | **YES** |
  custom-libcxx    | *no*    | Libcxx installation needed (TODO hunter?)
  xcode            | *no*    | Mac OS X only
  osx-10-9         | *no*    | Mac OS X only
  gcc              | **YES** |
  ios              | *no*    | Mac OS X only
  ios-i386-armv7   | *no*    | Mac OS X only
  ios-nocodesign   | *no*    | Mac OS X only
  android-...      | **YES** |
  analyze          | **YES** |
  sanitize-address | **YES** |
  sanitize-leak    | **YES** |
  sanitize-memory  | *no* | https://github.com/travis-ci-tester/travis-test-linux-clang-memory-sanitizer
  sanitize-thread  | *no* | https://github.com/ruslo/hunter/issues/718#issuecomment-290610583

### Windows (AppVeyor)

  name                 | support | notes
-----------------------|---------|------
default                | **YES** |
ninja-vs-12-2013-win64 | **YES** |
nmake-vs-12-2013-win64 | **YES** |
nmake-vs-12-2013       | **YES** |
vs-10-2010             | **YES** |
vs-11-2012             | **YES** |
vs-12-2013-win64       | **YES** |
vs-12-2013-xp          | **YES** |
vs-12-2013             | **YES** |
vs-14-2015             | **YES** |
vs-8-2005              | *no*    | [Not installed](http://www.appveyor.com/docs/installed-software)
vs-9-2008              | **YES** |
mingw                  | **YES** |