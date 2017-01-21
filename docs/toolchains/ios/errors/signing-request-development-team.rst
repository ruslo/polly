.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

Signing for "xxx" requires a development team
---------------------------------------------

If configure step fails with the error similar to:

.. code-block:: none

  Signing for "xxxxxx" requires a development team. Select a development
  team in the project editor.

First check that variable
:doc:`POLLY_IOS_DEVELOPMENT_TEAM </toolchains/ios/errors/polly_ios_development_team>`
is set. Second (if it doesn't help) try
`next steps <https://github.com/ruslo/polly/issues/102#issuecomment-264078385>`__:

* use Xcode to create a simple project for iOS
* set the bundle id to ``com.example``
* check the auto option
* Xcode automatically will download the provisioning profiles
* compile the project
* close Xcode
