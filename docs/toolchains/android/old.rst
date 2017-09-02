.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

.. spelling::

  taka

Migration to CMake 3.7.1+
-------------------------

Here is the table for migrating from toolchain based on `taka-no-me`_ project to
CMake 3.7.1+:

+---------------------------------+-------------------------------------------+
| taka-no-me                      | CMake 3.7.1+                              |
+=================================+===========================================+
| ANDROID_NATIVE_API_LEVEL        | `CMAKE_SYSTEM_VERSION`_                   |
+---------------------------------+-------------------------------------------+
| ANDROID_NDK                     | `CMAKE_ANDROID_NDK`_                      |
+---------------------------------+-------------------------------------------+
| ANDROID_STL                     | `CMAKE_ANDROID_STL_TYPE`_                 |
+---------------------------------+-------------------------------------------+
| ANDROID_NDK_ABI_NAME            | `CMAKE_ANDROID_ARCH_ABI`_                 |
+---------------------------------+-------------------------------------------+
| ANDROID_ARCH_NAME               | `CMAKE_ANDROID_ARCH`_                     |
+---------------------------------+-------------------------------------------+
| ANDROID_ABI                     | `CMAKE_ANDROID_ARCH_ABI`_ [1]_            |
+---------------------------------+-------------------------------------------+
| ANDROID_TOOLCHAIN_MACHINE_NAME  | `CMAKE_<LANG>_ANDROID_TOOLCHAIN_MACHINE`_ |
+---------------------------------+-------------------------------------------+
| ANDROID_COMPILER_VERSION        | `CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION`_    |
+---------------------------------+-------------------------------------------+
| ANDROID_NDK_HOST_SYSTEM_NAME    | `CMAKE_ANDROID_NDK_TOOLCHAIN_HOST_TAG`_   |
+---------------------------------+-------------------------------------------+

.. _taka-no-me: https://github.com/taka-no-me/android-cmake
.. _CMAKE_SYSTEM_VERSION: https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_VERSION.html
.. _CMAKE_ANDROID_NDK: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_NDK.html
.. _CMAKE_ANDROID_ARCH_ABI: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_ARCH_ABI.html
.. _CMAKE_ANDROID_ARCH: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_ARCH.html
.. _CMAKE_ANDROID_STL_TYPE: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_STL_TYPE.html
.. _CMAKE_CXX_ANDROID_TOOLCHAIN_MACHINE: https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_ANDROID_TOOLCHAIN_MACHINE.html
.. _CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION.html


.. [1] Additionally `CMAKE_ANDROID_ARM_MODE`_ and `CMAKE_ANDROID_ARM_NEON`_
  should be used for obtaining more accurate information about ABI

.. note::

  ``ANDROID_TOOLCHAIN_NAME`` has no analogy in CMake 3.7+.
  Closest is `CMAKE_CXX_ANDROID_TOOLCHAIN_MACHINE`_ with `CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION`_.

.. _CMAKE_ANDROID_ARM_MODE: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_ARM_MODE.html
.. _CMAKE_ANDROID_ARM_NEON: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_ARM_NEON.html

.. _CMAKE_<LANG>_ANDROID_TOOLCHAIN_MACHINE: https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_ANDROID_TOOLCHAIN_MACHINE.html
.. _CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION.html
.. _CMAKE_ANDROID_NDK_TOOLCHAIN_HOST_TAG: https://cmake.org/cmake/help/latest/variable/CMAKE_ANDROID_NDK_TOOLCHAIN_HOST_TAG.html
