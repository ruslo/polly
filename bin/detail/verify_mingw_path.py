# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import sys

def verify(mingw_path):
  if not mingw_path:
    sys.exit(
        "Please set environment variable MINGW_PATH "
        "to directory with mingw32-make.exe"
    )
  if not os.path.isdir(mingw_path):
    sys.exit("MINGW_PATH({}) is not a directory".format(mingw_path))

  mingw_make = os.path.join(mingw_path, 'mingw32-make.exe')
  if not os.path.isfile(mingw_make):
    sys.exit(
        "File mingw32-make.exe not found in "
        "directory `{}` (MINGW_PATH environment variable)".format(mingw_path)
    )
