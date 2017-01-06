.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

.. spelling::

  vc

Android
-------

.. toctree::
   :maxdepth: 1

   /toolchains/android/developer-notes

android-vc-*
============

Android toolchains for Visual Studio 14 2015 IDE.

.. admonition:: CGold

  * You have to install `additional tools`_ before using this toolchain

.. _additional tools: http://cgold.readthedocs.io/en/latest/platforms/android/windows.html

* Name: ``Android NDK r10e / c++11 support``
* Add ``CMAKE_CXX_FLAGS``: ``-std=c++11``
