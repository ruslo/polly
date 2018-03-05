.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

.. spelling::

  omp

clang-omp
---------

Download Clang from (tested with Clang 4.0):

* http://releases.llvm.org/

Save directory with Clang in environment variable ``CLANG_OMP_ROOT``.
Verify path:

.. code-block:: none

  > ls ${CLANG_OMP_ROOT}/bin/clang++
  /.../clang-4.0.0/bin/clang++

Runtime
=======

To run executable you should provide a path to shared OpenMP library.

Modify ``DYLD_LIBRARY_PATH`` on OSX:

.. code-block:: none

  > export DYLD_LIBRARY_PATH=${CLANG_OMP_ROOT}/lib:${DYLD_LIBRARY_PATH}
