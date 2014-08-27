# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import re

def get(ios_version):
  dev_dir = re.sub(r'\.', '_', ios_version)
  dev_dir = 'IOS_{}_DEVELOPER_DIR'.format(dev_dir)
  return os.getenv(dev_dir)
