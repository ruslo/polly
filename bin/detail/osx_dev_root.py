# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import os
import re

def get(osx_version):
  dev_dir = re.sub(r'\.', '_', osx_version)
  dev_dir = 'OSX_{}_DEVELOPER_DIR'.format(dev_dir)
  return os.getenv(dev_dir)
