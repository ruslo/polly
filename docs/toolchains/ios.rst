.. Copyright (c) 2016-2017, Ruslan Baratov
.. All rights reserved.

iOS
---

.. spelling::

  ios
  multiarch
  nocodesign

ios-X-Y-*
=========

.. toctree::
  :hidden:

  ios/bundle-id

.. warning::

  Please check before you start:

  * Xcode version >= 5.0
  * CMake version >= 3.5
  * Since ``iOS 10.0`` you have to define ``POLLY_IOS_DEVELOPMENT_TEAM``
    variable. See
    :doc:`POLLY_IOS_DEVELOPMENT_TEAM </toolchains/ios/errors/polly_ios_development_team>`
    for details
  * Check :doc:`code signing works <ios/bundle-id>`

* Name: ``iOS X.Y Universal (iphoneos + iphonesimulator) / c++11 support``
* Add ``CMAKE_CXX_FLAGS``: ``-std=c++11``
* Defaults to fix `try_compile <http://www.cmake.org/cmake/help/v2.8.12/cmake.html#command:try_compile>`__ command:

 * Set ``MACOSX_BUNDLE_GUI_IDENTIFIER`` to ``com.example``
 * Set ``CMAKE_MACOSX_BUNDLE`` to ``YES``
 * Set ``CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY`` to ``iPhone Developer``

* Set ``CMAKE_OSX_SYSROOT`` to ``iphoneos``
* Set ``IPHONEOS_ARCHS`` to ``armv7;armv7s;arm64``
* Set ``IPHONESIMULATOR_ARCHS`` to ``i386;x86_64``
* Set ``XCODE_DEVELOPER_ROOT`` to ``xcode-select -print-path`` (e.g. ``/Applications/Xcode.app/Contents/Developer/``)
* Set ``IPHONESIMULATOR_ROOT``/``IPHONEOS_ROOT`` (e.g.
  ``/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer``)
* Set ``IPHONESIMULATOR_SDK_ROOT``/``IPHONEOS_SDK_ROOT`` using ``IPHONE*_ROOT`` and ``IOS_SDK_VERSION``
  (e.g. ``/.../Xcode.app/.../iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk/``)

.. note::

  * ``build.py --ios-multiarch`` will **build** multi-architecture binary
    (apply ``CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO``).
    I.e. ``armv7 armv7s arm64`` instead of ``armv7`` only
  * ``build.py --ios-combined`` will **install** combined simulator + device
    binary (apply ``CMAKE_IOS_INSTALL_COMBINED=YES``). I.e. ``armv7 i386`` instead of ``armv7``
  * ``build.py --ios-multiarch --ios-combined`` will build multiarch binary and
    combine device/simulator binaries, i.e. final binary will be
    ``i386 armv7 armv7s x86_64 arm64``

.. note::

  * `Keychain unlock note <http://stackoverflow.com/a/581002/2288008>`__

.. note::

  * ``build.py`` script can detect environment variables
    ``IOS_X_Y_DEVELOPER_DIR`` to set ``DEVELOPER_DIR`` to appropriate value,
    e.g. switching between `7.0` and `7.1`:

    .. code-block:: bash

      export IOS_7_1_DEVELOPER_DIR=/Applications/xcode/5.1.1/Xcode.app/Contents/Developer
      export IOS_7_0_DEVELOPER_DIR=/Applications/xcode/5.0.2/Xcode.app/Contents/Developer

Xcode SDK installed by default:

+-------+------+-------+-----+
| Xcode | OS X | OS X  | iOS |
+-------+------+-------+-----+
| 4.6.3 | 10.7 | 10.8  | 6.1 |
+-------+------+-------+-----+
| 5.0.2 | 10.8 | 10.9  | 7.0 |
+-------+------+-------+-----+
| 5.1.1 | 10.8 | 10.9  | 7.1 |
+-------+------+-------+-----+
| 6.0.1 | 10.9 |       | 8.0 |
+-------+------+-------+-----+
| 6.1.1 | 10.9 | 10.10 | 8.1 |
+-------+------+-------+-----+
| 6.2   | 10.9 | 10.10 | 8.2 |
+-------+------+-------+-----+
| 6.4   | 10.9 | 10.10 | 8.4 |
+-------+------+-------+-----+
| 7.0   | 10.11|       | 9.0 |
+-------+------+-------+-----+
| 7.1   | 10.11|       | 9.1 |
+-------+------+-------+-----+
| 7.2   | 10.11|       | 9.2 |
+-------+------+-------+-----+
| 7.2.1 | 10.11|       | 9.2 |
+-------+------+-------+-----+
| 7.3   | 10.11|       | 9.3 |
+-------+------+-------+-----+
| 8.0   | 10.12|       |10.0 |
+-------+------+-------+-----+
| 8.1   | 10.12|       |10.1 |
+-------+------+-------+-----+
| 8.2   | 10.12|       |10.2 |
+-------+------+-------+-----+
| 8.3.1 | 10.12|       |10.3 |
+-------+------+-------+-----+
| 9.0   | 10.13|       |11.0 |
+-------+------+-------+-----+
| 9.1   | 10.13|       |11.1 |
+-------+------+-------+-----+
| 9.2   | 10.13|       |11.2 |
+-------+------+-------+-----+
| 9.3   | 10.13|       |11.3 |
+-------+------+-------+-----+

ios-X-Y-<arch1>-<arch2>
=======================

* Name: ``iOS X.Y Universal (iphoneos + iphonesimulator) / <arch1> / <arch2> / c++11 support``
* Same as ``ios-*``, but limited to ``<arch1>`` and ``<arch2>`` architectures
* Example: ``ios-9-0-i386-armv7``

ios-nocodesign-X-Y
==================

* Name: ``iOS X.Y Universal (iphoneos + iphonesimulator) / No code sign / c++11 support``
* Same as ``ios-*``, but without ``CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY``
* Very helpful in server testing (no need to install developer certificate)

.. warning::

  * If you're not using ``polly.py`` script you have to define
    ``XCODE_XCCONFIG_FILE`` environment variable with path
    to ``$POLLY_ROOT/scripts/NoCodeSign.xcconfig`` file (do not forget ``export``!)

Errors
======

.. toctree::
   :maxdepth: 1
   :glob:

   /toolchains/ios/errors/*
