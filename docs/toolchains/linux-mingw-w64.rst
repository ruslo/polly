.. Copyright (c) 2017, NeroBurner
.. All rights reserved.

.. spelling::

  mingw

mingw-w64
=========

mingw-w64 http://mingw-w64.org/ cross compiling toolchain to compile for Windows on Linux host.

Install mingw-w64 cross compiler:

.. code-block:: none

  > sudo apt-get -y install mingw-w64

Test if the compiler is installed correctly

.. code-block:: none

  > x86_64-w64-mingw32-gcc --version
  x86_64-w64-mingw32-gcc (GCC) 5.3.1 20160211
  Copyright (C) 2015 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
