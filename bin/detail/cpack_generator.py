# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import platform

available_generators = [
    '7Z',
    'IFW',
    'NSIS',
    'NSIS64',
    'STGZ',
    'TBZ2',
    'TGZ',
    'TXZ',
    'TZ',
    'ZIP',
]

if platform.system() == 'Darwin':
  available_generators += [
      'Bundle',
      'DragNDrop',
      'OSXX11',
      'PackageMaker',
  ]

if platform.system().startswith('CYGWIN'):
  available_generators += [
      'CygwinBinary',
      'CygwinSource',
      'DEB',
      'RPM',
  ]

if platform.system() == 'Linux':
  available_generators += [
      'DEB',
      'RPM',
  ]

if os.name == 'nt':
  available_generators += [
      'WIX'
  ]

def default():
  if os.name == 'nt':
    return 'NSIS'
  if platform.system() == 'Darwin':
    return 'PackageMaker'
  if platform.system() == 'Linux':
    return 'DEB'
  return 'TGZ'
