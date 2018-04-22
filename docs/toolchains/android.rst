.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

.. spelling::

  vc
  ndk
  api

Android
-------

.. seealso::

  * `Android history by API level <https://en.wikipedia.org/wiki/Android_version_history#Version_history_by_API_level>`__
  * `Android ABI management <https://developer.android.com/ndk/guides/abis.html>`__

android-ndk-X-api-Y-*
=====================

Android toolchain.

* Name: ``Android NDK X / API Y / ... / c++11 support``
* Add ``CMAKE_CXX_FLAGS``: ``-std=c++11``

.. note::

  * Minimum version of CMake is 3.7.1
  * `v0.10.2 <https://github.com/ruslo/polly/releases/tag/v0.10.2>`__
    is the latest release which do support version of CMake less than 3.7.1
    (based on `taka-no-me`_ toolchain)

.. toctree::
   :maxdepth: 1

   /toolchains/android/old

.. _taka-no-me: https://github.com/taka-no-me/android-cmake

android-vc-ndk-X-api-Y-*
========================

Android toolchains for Visual Studio 14 2015 IDE.

.. admonition:: CGold

  * You have to install `additional tools`_ before using this toolchain

.. _additional tools: http://cgold.readthedocs.io/en/latest/platforms/android/windows.html

* Name: ``Android NDK X / API Y / ... / c++11 support``
* Add ``CMAKE_CXX_FLAGS``: ``-std=c++11``

.. toctree::
   :maxdepth: 1

   /toolchains/android/developer-notes
