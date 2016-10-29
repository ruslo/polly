.. Copyright (c) 2016, Ruslan Baratov
.. All rights reserved.

POLLY_IOS_DEVELOPMENT_TEAM
==========================

Since ``iOS 10.0`` users have to
`set Team ID explicitly <https://github.com/ruslo/polly/issues/102>`__
in CMake code. Polly will set corresponding global Xcode attribute
``CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM`` automatically using value of
environment variable ``POLLY_IOS_DEVELOPMENT_TEAM``.

You can find your Team ID by visiting this page:

* https://developer.apple.com/account/#/membership

.. image:: /screens/ios-team-id.png
  :align: center

Example:

.. code-block:: none

  > grep POLLY_IOS_DEVELOPMENT_TEAM ~/.bashrc
  export POLLY_IOS_DEVELOPMENT_TEAM="KDKA6UJ6WT"

.. admonition:: Stackoverflow

  * `How can I find my Apple Developer Team ID? <http://stackoverflow.com/a/18727947/2288008>`__
