# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

# Call native tools to remove directory recursively. Use this command instead
# of shutils.rmtree because of different glitches like impossibility to remove
# directory with files with long path on Windows.

import os
import subprocess
import sys

def rmtree(dir_path):
  if not os.path.exists(dir_path):
    return
  print("Remove directory: {}".format(dir_path))
  if os.name == 'nt':
    subprocess.check_call(['cmd', '/c', 'rmdir', dir_path, '/S', '/Q'])
  else:
    subprocess.check_call(['rm', '-rf', dir_path])

  # sanity check
  if os.path.exists(dir_path):
    sys.exit("Directory removing failed ({})".format(dir_path))
