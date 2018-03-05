.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

.. spelling::

  xxx

Signing for "xxx" requires a development team
---------------------------------------------

If configure step fails with the error similar to:

.. code-block:: none

  Signing for "xxxxxx" requires a development team. Select a development
  team in the project editor.

First check that variable
:doc:`POLLY_IOS_DEVELOPMENT_TEAM </toolchains/ios/errors/polly_ios_development_team>`
is set. Second verify that ``com.example`` can be used as a
:doc:`bundle ID </toolchains/ios/bundle-id>`.
