# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import sys

def verify(msys_path):
  if not msys_path:
    sys.exit(
        "Please set environment variable MSYS_PATH "
        "to directory with make.exe"
    )
  make_found = False
  for path in msys_path.split(';'):
    if not os.path.isdir(path):
      sys.exit(
          "One of the MSYS_PATH components is not a directory: {} ".
              format(path)
      )
    msys_make = os.path.join(path, 'make.exe')
    if os.path.isfile(msys_make):
      make_found = True

  if not make_found:
    sys.exit(
        "File make.exe not found in "
        "directories `{}` (MSYS_PATH environment variable)".format(msys_path)
    )
