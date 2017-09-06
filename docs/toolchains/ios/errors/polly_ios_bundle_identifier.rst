.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

POLLY_IOS_BUNDLE_IDENTIFIER
===========================
When using an Apple Enterprise developer account, the ``CMAKE_TRY_COMPILE`` step
can fail with this message

.. code-block:: none

  No profiles for 'com.example' were found: Xcode couldn't find a
  provisioning profile matching 'com.example'.


You can bypass this problem by creating a project with a unique bundle
identifier, i.e. ``com.<company-name>.example`` and setting the environment
variable ``POLLY_IOS_BUNDLE_IDENTIFIER``. If the environment variable exists,
Polly will set the corresponding CMake variable ``MACOSX_BUNDLE_GUI_IDENTIFIER``
, otherwise it is set to ``com.example``.

.. code-block:: none

  > grep POLLY_IOS_BUNDLE_IDENTIFIER ~/.bashrc
  export POLLY_IOS_BUNDLE_IDENTIFIER="com.<company-name>.example"
