Download `libcxx` sources and `polly` toolchains and examples (can be done in one step using [gitenv](https://github.com/ruslo/gitenv)):
```bash
> git clone https://github.com/ruslo/gitenv
> cd gitenv
> git submodule update --init llvm/libcxx polly
# update submodules
> git submodule foreach 'git checkout master && git pull'
# remember polly directory to reduce some typing job
> export POLLY_ROOT=`pwd`/polly
# build libcxx
> cd llvm/libcxx
> mkdir Install
# this variable will be used in find_package
> export LIBCXX_ROOT=`pwd`/Install
```
Building debug static version (*Note*: `CMAKE_DEBUG_POSTFIX`):
```bash
> mkdir -p _builds/make-debug
> cd _builds/make-debug
> cmake -DCMAKE_INSTALL_PREFIX=${LIBCXX_ROOT} -DLIBCXX_ENABLE_SHARED=OFF -DCMAKE_BUILD_TYPE=Debug -DCMAKE_DEBUG_POSTFIX=d ../..
> make VERBOSE=1 install
...
/usr/bin/c++ ... -D_DEBUG -D_LIBCPP_BUILD_STATIC ...
...
> cd ../..
> ls Install/lib/libc++d.a 
Install/lib/libc++d.a
```

Release (*Note*: `LIBCXX_ENABLE_ASSERTIONS`):
```bash
> mkdir -p _builds/make-release
> cd _builds/make-release
> cmake -DCMAKE_INSTALL_PREFIX=${LIBCXX_ROOT} -DLIBCXX_ENABLE_SHARED=OFF -DLIBCXX_ENABLE_ASSERTIONS=OFF -DCMAKE_BUILD_TYPE=Release ../..
> make VERBOSE=1 install
...
/usr/bin/c++ ... -O3 -DNDEBUG ...
...
> cd ../..
> ls Install/lib/libc++.a 
Install/lib/libc++.a
```

### Build example
`custom_libcxx.cmake` toolchain file can be used with `CMAKE_BUILD_TYPE` to link target to custom debug `libcxx` (*Note*: environment variable `LIBCXX_ROOT` used to detect both `libc++` libraries): 
```bash
> cd ${POLLY_ROOT}/examples/01-executable
> mkdir -p _builds/make-debug
> cd _builds/make-debug
> cmake -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/custom_libcxx.cmake -DCMAKE_BUILD_TYPE=Debug -DLibcxx_USE_STATIC_LIBS=ON ../..
> make VERBOSE=1
/usr/bin/c++ ... /.../llvm/libcxx/Install/lib/libc++d.a /usr/lib/libc++abi.dylib
```

Same with release:
```bash
> cd ${POLLY_ROOT}/examples/01-executable
> mkdir -p _builds/make-release
> cd _builds/make-release
> cmake -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/custom_libcxx.cmake -DCMAKE_BUILD_TYPE=Release -DLibcxx_USE_STATIC_LIBS=ON ../..
> make VERBOSE=1
/usr/bin/c++ ... /.../llvm/libcxx/Install/lib/libc++.a /usr/lib/libc++abi.dylib
```

`Default.cmake` toolchain file can be used to link to standard `libcxx` library:
```bash
> cd ${POLLY_ROOT}/examples/01-executable
> mkdir -p _builds/make-default
> cd _builds/make-default
> cmake -DCMAKE_TOOLCHAIN_FILE=${POLLY_ROOT}/default.cmake ../..
> make VERBOSE=1
/usr/bin/c++ -Wl,-search_paths_first -Wl,-headerpad_max_install_names CMakeFiles/simple_bin.dir/main.cpp.o -o simple_bin
```

**Note that**:
* `Libcxx_LIBRARIES` variable holds two version of library: debug(libc++d.a) and release(libc++.a). If `target_link_libraries` cmake function is used to link, corresponding version will be automatically selected.
`Libcxx_LIBRARY_DEBUG` and `Libcxx_LIBRARY_RELEASE` variables can be used to link library explicitly.
* `Libcxx_LIBRARIES` variable holds two libraries: `libc++` and `libc++abi`. `Libcxx_LIBRARY` and `LibcxxAbi_LIBRARY` variables can be used to link libraries explicitly.
* `Libcxx_USE_STATIC_LIBS` can be used to choose shared or static version (similar to [Boost_USE_STATIC_LIBS][1])

[1]: http://www.cmake.org/cmake/help/v2.8.12/cmake.html#module:FindBoost
[2]: https://github.com/ruslo/gitenv/blob/master/gitenv/paths.cmake