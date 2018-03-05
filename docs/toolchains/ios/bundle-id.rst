.. Copyright (c) 2017, Ruslan Baratov
.. All rights reserved.

Bundle ID
---------

By default Polly will try to use ``com.example`` bundle ID in iOS projects.
Please follow this steps before you start working with iOS toolchains:

* Create **native** simple Xcode project without using CMake: start Xcode
  and click :menuselection:`File --> New --> Project...`:

  .. image:: screens/01_new_project.png
    :align: center

* Choose some template (e.g. ``Single View App``) and click ``Next``:

  .. image:: screens/02_single_view_app.png
    :align: center

* Fill "Product Name" with any name and set "Organization Identifier"
  to ``com.example``, click ``Next``:

  .. image:: screens/03_project_options.png
    :align: center

* Verify that "Automatically manage signing" is checked.
  **Set "Bundle Identifier" to "com.example" (!)**:

  .. image:: screens/04_bundle_identifier.png
    :align: center

* If you see this error

  .. code-block:: none

    The app ID "com.example" cannot be registered to your development team.
    Change your bundle identifier to a unique string to try again.

  .. image:: screens/bad_bundle_id.png
    :align: center

  it means you can't use ``com.example`` as default bundle ID and have
  to find and save another one. Try ``com.example.polly`` or any other random
  string. Then **save this string** to
  :doc:`POLLY_IOS_BUNDLE_IDENTIFIER <errors/polly_ios_bundle_identifier>`
  environment variable so Polly can use it.

* Run example on real device. By this you will verify that build and signing
  is working correctly:

  .. image:: screens/05_run_app.png
    :align: center

.. note::

  Related issues:

  * https://github.com/ruslo/polly/issues/102
  * https://github.com/ruslo/polly/issues/170
