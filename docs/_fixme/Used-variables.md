### POLLY_TOOLCHAIN_NAME
Name of a toolchain that is used.
### POLLY_TOOLCHAIN_TAG
Toolchain tag. *Can* be used to modify install directory. Coincide with toolchain name file.

*Example*: `libcxx.cmake` toolchain define tag as `set(POLLY_TOOLCHAIN_TAG libcxx)`
### POLLY_STATUS_PRINT
Option with default value `TRUE`. If this variable is set to `TRUE` process information will be printed.
### POLLY_STATUS_DEBUG
Option with default value `FALSE`. Works like `POLLY_STATUS_PRINT` (more verbose).
### CUSTOM_LIBCXX_LIBRARY_LOCATION
Setted by `CustomLibcxx.cmake` toolchain. If this variable is `TRUE`, you need to find libcxx yourself:
```cmake
if(CUSTOM_LIBCXX_LIBRARY_LOCATION)
  find_package(Libcxx REQUIRED)
  include_directories(${Libcxx_INCLUDE_DIRS})
  target_link_libraries(mytarget ${Libcxx_LIBRARIES})
endif()
```