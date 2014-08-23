# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import platform

def get(cpack):
  if not cpack:
    return ''
  if os.name == 'nt':
    return 'NSIS'
  if platform.system() == 'Darwin':
    return 'PackageMaker'
  if platform.system() == 'Linux':
    if platform.linux_distribution()[0] == 'Ubuntu':
      cpack_generator = 'DEB'
  return ''
