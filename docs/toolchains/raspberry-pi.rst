.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

Raspberry Pi
------------

.. seealso::

  * `Official <https://www.raspberrypi.org/>`__
  * `Hardware Guide <https://www.raspberrypi.org/learning/hardware-guide/>`__
  * `Formatting SDCard <https://www.raspberrypi.org/documentation/installation/sdxc_formatting.md>`__
  * `Download Software <https://www.raspberrypi.org/downloads/noobs/>`__
  * `What password to use to log in after the first boot? <https://raspberrypi.stackexchange.com/q/660/70510>`__

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

Use ``gcc`` toolchain, e.g.:

.. code-block:: none

  > polly.py --toolchain gcc --verbose --config Release
