.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

Android
-------

``android-vc-*``
================

Android toolchains for Visual Studio 14 2015 IDE.

.. admonition:: CGold

  * You have to install `additional tools`_ before using this toolchain

.. _additional tools: http://cgold.readthedocs.io/en/latest/platforms/android/windows.html

* Name: ``Android NDK r10e / c++11 support``
* Add ``CMAKE_CXX_FLAGS``: ``-std=c++11``

Developer notes
===============

Visual Studio controlling variables:

* `CMAKE_VC_MDD_ANDROID_API_LEVEL <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/prop_tgt/VC_MDD_ANDROID_API_LEVEL.rst>`__
* `CMAKE_VC_MDD_ANDROID_PLATFORM_TOOLSET <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/prop_tgt/VC_MDD_ANDROID_PLATFORM_TOOLSET.rst>`__
* `CMAKE_VC_MDD_ANDROID_USE_OF_STL <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/prop_tgt/VC_MDD_ANDROID_USE_OF_STL.rst>`__

Provide Information:

* `VC_MDD <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/variable/VC_MDD.rst>`__
* `VC_MDD_ANDROID <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/variable/VC_MDD_ANDROID.rst>`__
* `VC_MDD_ANDROID_VERSION <https://github.com/Microsoft/CMake/blob/feature/VCMDDAndroid/Help/variable/VC_MDD_ANDROID_VERSION.rst>`__

Mapping:

+---------------------------+------------------------------+-------------------------------------------------------+
| Polly                     | `OpenCV`_                    | `VCMDDAndroid`_                                       |
+===========================+==============================+=======================================================+
| ANDROID_NDK_VERSION       | Used to set ANDROID_NDK path | Not implemented [1]_ (default value is ``r10e``)      |
+---------------------------+------------------------------+-------------------------------------------------------+
| ANDROID_NATIVE_API_LEVEL  | Used as is                   | CMAKE_VC_MDD_ANDROID_API_LEVEL                        |
+---------------------------+------------------------------+-------------------------------------------------------+
| ANDROID_ABI               | Used as is                   | Not used. Architecture set by generator name          |
+---------------------------+------------------------------+-------------------------------------------------------+
| ANDROID_TOOLCHAIN_NAME    | Used as is                   | CMAKE_VC_MDD_ANDROID_PLATFORM_TOOLSET                 |
+---------------------------+------------------------------+-------------------------------------------------------+
| default [2]_              | ANDROID_STL                  | CMAKE_VC_MDD_ANDROID_USE_OF_STL                       |
+---------------------------+------------------------------+-------------------------------------------------------+

.. _OpenCV: https://github.com/taka-no-me/android-cmake
.. _VCMDDAndroid: https://github.com/Microsoft/CMake/tree/feature/VCMDDAndroid

.. [1] From `comments <https://blogs.msdn.microsoft.com/vcblog/2015/12/15/support-for-android-cmake-projects-in-visual-studio>`__:
  "This is not exposed thru CMake".
.. [2] ``gnustl_static``
