# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import detail.call

import glob
import os
import re
import shutil
import sys

def get_framework_name(lib_name):
  if re.match(r'^lib.*\.a$', lib_name):
    return re.sub(r'^lib(.*)\.a$', r'\1', lib_name)
  if re.match(r'^lib.*\.dylib$', lib_name):
    return re.sub(r'^lib(.*)\.dylib$', r'\1', lib_name)
  sys.exit('Incorrect library name `{}`. Expected format lib*.a or lib*.dylib')

def run(install_dir, framework_dir, logging):
  libs = glob.glob(os.path.join(install_dir, 'lib', '*'))
  if len(libs) != 1:
    sys.exit('Expected only one lib in directory _install/lib')

  lib_name = os.path.basename(libs[0])

  framework_name = get_framework_name(lib_name)

  framework_dir = os.path.join(
      framework_dir, '{}.framework'.format(framework_name)
  )
  if os.path.exists(framework_dir):
    shutil.rmtree(framework_dir)

  lib_dir = os.path.join(framework_dir, 'Versions', 'A')
  headers_dir = os.path.join(framework_dir, 'Versions', 'A', 'Headers')

  os.makedirs(lib_dir)
  os.makedirs(headers_dir)

  shutil.copy(libs[0], os.path.join(lib_dir, framework_name))

  incl_dir = os.path.join(install_dir, 'include', framework_name)
  for root, dirs, files in os.walk(incl_dir):
    for d in dirs:
      d_rel = os.path.relpath(os.path.join(root, d), incl_dir)
      x = os.path.join(headers_dir, d_rel)
      if not os.path.exists(x):
        os.makedirs(x)
    for f in files:
      f_rel = os.path.relpath(os.path.join(root, f), incl_dir)
      shutil.copy(os.path.join(root, f), os.path.join(headers_dir, f_rel))

  link = ['ln', '-sfh', 'A', os.path.join(framework_dir, 'Versions', 'Current')]
  detail.call.call(link, logging)

  link = [
      'ln',
      '-sfh',
      os.path.join('Versions', 'Current', framework_name),
      os.path.join(framework_dir, framework_name)
  ]
  detail.call.call(link, logging)

  link = [
      'ln',
      '-sfh',
      os.path.join('Versions', 'Current', 'Headers'),
      os.path.join(framework_dir, 'Headers')
  ]
  detail.call.call(link, logging)
  print('Framework created: {}'.format(framework_dir))
