.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

.. spelling::

  Raspbian

Raspberry Pi
------------

.. seealso::

  * `Official <https://www.raspberrypi.org/>`__
  * `Hardware Guide <https://www.raspberrypi.org/learning/hardware-guide/>`__
  * `Formatting SDCard <https://www.raspberrypi.org/documentation/installation/sdxc_formatting.md>`__
  * `Download Software <https://www.raspberrypi.org/downloads/noobs/>`__
  * `What password to use to log in after the first boot? <https://raspberrypi.stackexchange.com/q/660/70510>`__

Raspbian (native)
=================

Instructions for `Raspbian <https://www.raspberrypi.org/downloads/raspbian/>`__:

.. code-block:: none
  :emphasize-lines: 3

  > lsb_release -a
  No LSB modules are available.
  Distributor ID: Raspbian
  Description:    Raspbian GNU/Linux 8.0 (jessie)
  Release:        8.0
  Codename:       jessie


.. code-block:: none

  > sudo apt-get install python3
  > sudo apt-get install g++
  > sudo apt-get install cmake

Use ``raspberrypi*-cxx11`` toolchain, e.g. ``raspberrypi3-cxx11``:

.. code-block:: none
  :emphasize-lines: 3

  > polly.py --toolchain raspberrypi3-cxx11 --verbose --config Release
  ...
  -- [polly] Raspberry Pi host
  ...

Cross-compiling
===============

Ubuntu
~~~~~~

.. seealso::

  * `Kernel building <https://www.raspberrypi.org/documentation/linux/kernel/building.md>`__

Download tools:

.. code-block:: none

  > git clone https://github.com/raspberrypi/tools raspberrypi-tools

Save paths in environment variables:

.. code-block:: none

  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH=/.../raspberrypi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX=arm-linux-gnueabihf
  > export RASPBERRYPI_CROSS_COMPILE_SYSROOT=/.../raspberrypi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf/libc


GCC 4.9 configuration:

.. code-block:: none

  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH=/.../raspberrypi-tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin/
  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX=arm-linux-gnueabihf
  > export RASPBERRYPI_CROSS_COMPILE_SYSROOT=/.../raspberrypi-tools/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/arm-linux-gnueabihf/sysroot

Use ``raspberrypi*-cxx11`` toolchain, e.g. ``raspberrypi3-cxx11``:

.. code-block:: none

  > polly.py --toolchain raspberrypi3-cxx11 --verbose --config Release

OSX
~~~

Download tools:

.. code-block:: none

  > git clone https://github.com/pretyman/raspberrypi2-mac-crosscompiler raspberrypi-tools

Save paths in environment variables:

.. code-block:: none

  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PATH=/.../raspberrypi-tools/x-tools/arm-unknown-linux-gnueabihf/bin/
  > export RASPBERRYPI_CROSS_COMPILE_TOOLCHAIN_PREFIX=arm-unknown-linux-gnueabihf
  > export RASPBERRYPI_CROSS_COMPILE_SYSROOT=/.../raspberrypi-tools/x-tools/arm-unknown-linux-gnueabihf/arm-unknown-linux-gnueabihf/sysroot

Use ``raspberrypi*-cxx11`` toolchain, e.g. ``raspberrypi3-cxx11``:

.. code-block:: none

  > polly.py --toolchain raspberrypi3-cxx11 --verbose --config Release

Clang
~~~~~

Download and unpack ``rpi-sysroot.tar.xz`` archive:

.. code-block:: none

  > wget https://sourceforge.net/projects/avbuild/files/raspberry-pi/rpi-sysroot.tar.xz
  > tar xf rpi-sysroot.tar.xz
  > export RPI_SYSROOT=`pwd`/sysroot

Verify:

.. code-block:: none

  > ls -d $RPI_SYSROOT/usr/include
  /.../sysroot/usr/include/

Use ``raspberry3-clang-cxx11`` toolchain:

.. code-block:: none

  > polly.py --toolchain raspberrypi3-clang-cxx11 --verbose --config Release

.. seealso::

  - `Raspberry Pi: Cross-compiling with Clang <https://github.com/wang-bin/avbuild/wiki/Raspberry-Pi-Cross-Build#clang>`__
