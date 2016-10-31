.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

.. spelling::

  thru

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

+---------------------------+------------------------------+
| `Polly`_                  | `OpenCV`_                    |
+===========================+==============================+
| ANDROID_NDK_VERSION       | Used to set ANDROID_NDK path |
+---------------------------+------------------------------+
| ANDROID_NATIVE_API_LEVEL  | Used as is                   |
+---------------------------+------------------------------+
| ANDROID_ABI               | Used as is                   |
+---------------------------+------------------------------+
| ANDROID_TOOLCHAIN_NAME    | Used as is                   |
+---------------------------+------------------------------+

.. note::

  * ANDROID_STL set by default to ``gnustl_static``

+---------------------------------------+--------------------------------------------+
| `Polly`_                              | `VCMDDAndroid`_                            |
+=======================================+============================================+
| ANDROID_NDK_VERSION                   | Always set to ``r10e`` [1]_.               |
|                                       | Used to verify ANDROID_NDK [2]_            |
+---------------------------------------+--------------------------------------------+
| ANDROID_NATIVE_API_LEVEL              | Used to set CMAKE_VC_MDD_ANDROID_API_LEVEL |
+---------------------------------------+--------------------------------------------+
| ANDROID_ABI                           | Used to set ANDROID_ARCH_NAME [3]_         |
+---------------------------------------+--------------------------------------------+
| CMAKE_VC_MDD_ANDROID_PLATFORM_TOOLSET | Used as is                                 |
+---------------------------------------+--------------------------------------------+

.. note::

  * CMAKE_VC_MDD_ANDROID_USE_OF_STL set by default to ``gnustl_static``

.. _Polly: https://github.com/ruslo/polly
.. _OpenCV: https://github.com/taka-no-me/android-cmake
.. _VCMDDAndroid: https://github.com/Microsoft/CMake/tree/feature/VCMDDAndroid

.. [1] From `comments <https://blogs.msdn.microsoft.com/vcblog/2015/12/15/support-for-android-cmake-projects-in-visual-studio>`__:
  "This is not exposed thru CMake".
.. [2] NDK dir taken from [HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\VisualStudio\\14.0_Config\\Setup\\vs\\SecondaryInstall\\AndroidNDK64\\NDK_HOME]
.. [3] ANDROID_ARCH_NAME used to set ANDROID_TOOLCHAIN_NAME and ANDROID_TOOLCHAIN_MACHINE_NAME
