.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

.. spelling::

  gcc
  musl
  libc

gcc-musl
========

GCC toolchain with `musl libc <http://www.musl-libc.org/>`__ instead of
GNU libc.

You have to build/install GCC and save path to compiler in ``GCC_MUSL_ROOT``
environment variable. Instructions for Ubuntu are below.

Install GCC dependencies:

.. code-block:: none

  > sudo apt-get -y install libgmp-dev libmpfr-dev libmpc-dev

Download building scripts:

.. code-block:: none

  > git clone https://github.com/sabotage-linux/musl-cross
  > cd musl-cross
  [musl-cross]>

Set installation path by updating ``CC_BASE_PREFIX`` variable:

.. code-block:: none

  [musl-cross]> vim config.sh

Run build/install:

.. code-block:: none

  [musl-cross]> ./build.sh

Save path to ``GCC_MUSL_ROOT`` variable
(you may want to save it in ``.bashrc``):

.. code-block:: none

  > export GCC_MUSL_ROOT=/.../x86_64-linux-musl/bin

Verify path:

.. code-block:: none

  > "$GCC_MUSL_ROOT/x86_64-linux-musl-gcc" --version
  x86_64-linux-musl-gcc (GCC) 5.3.0
  Copyright (C) 2015 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
