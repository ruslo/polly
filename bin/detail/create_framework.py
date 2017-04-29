# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import detail.call
import detail.rmtree

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

def get_libname_soversion(libs):
  name_len = min([len(x) for x in libs])
  for x in libs:
    if (len(x) == name_len) and os.path.islink(x):
      return x
  sys.exit('Unexpected version/soversion format: {}'.format(libs))

def run(install_dir, framework_dir, ios, polly_root, device, logging, plist=None, identity=None, lib_regex='*'):
  libs_path = os.path.join(install_dir, 'lib')
  libs = glob.glob(os.path.join(libs_path, lib_regex))
  try:
    libs.remove(os.path.join(libs_path, 'cmake'))
  except ValueError:
    pass

  if len(libs) == 0:
    sys.exit('No libs found in directory: {}'.format(libs_path))

  if len(libs) == 3:
    # SOVERSION install:
    #   1) lib<name>.dylib (symlink)
    #   2) lib<name>.N.dylib (symlink)
    #   3) lib<name>.N.M.dylib (real file)
    lib_name = os.path.basename(get_libname_soversion(libs))
  elif len(libs) == 1:
    lib_name = os.path.basename(libs[0])
  else:
    sys.exit(
        'Expected only one lib in directory: {}'.format(libs_path) +
        '\nBut found: {}'.format(libs)
    )

  framework_name = get_framework_name(lib_name)

  framework_dir = os.path.join(
      framework_dir, '{}.framework'.format(framework_name)
  )
  detail.rmtree.rmtree(framework_dir)

  if ios:
    lib_dir = os.path.join(framework_dir)
    headers_dir = os.path.join(framework_dir, 'Headers')
  else:
    lib_dir = os.path.join(framework_dir, 'Versions', 'A')
    headers_dir = os.path.join(framework_dir, 'Versions', 'A', 'Headers')

  os.makedirs(lib_dir)
  os.makedirs(headers_dir)

  framework_lib = os.path.join(lib_dir, framework_name)
  shutil.copy(libs[0], framework_lib)
  if libs[0].endswith('.dylib'):
    cmd = [
        'install_name_tool',
        '-id',
        '@rpath/{}.framework/{}'.format(framework_name, framework_name),
        framework_lib
    ]
    detail.call.call(cmd, logging)

  header_found = False
  incl_dir = os.path.join(install_dir, 'include', framework_name)
  for root, dirs, files in os.walk(incl_dir):
    for d in dirs:
      d_rel = os.path.relpath(os.path.join(root, d), incl_dir)
      x = os.path.join(headers_dir, d_rel)
      if not os.path.exists(x):
        os.makedirs(x)
    for f in files:
      header_found = True
      f_rel = os.path.relpath(os.path.join(root, f), incl_dir)
      shutil.copy(os.path.join(root, f), os.path.join(headers_dir, f_rel))

  if not header_found:
    print('Warning: no headers found for framework (dir: {})'.format(incl_dir))

  if not ios:
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
  else:
    framework_plist = os.path.join(framework_dir, 'Info.plist')
    if plist is None:
      shutil.copy(
        os.path.join(polly_root, 'scripts', 'Info.plist'),
        framework_plist);
    else:
      shutil.copy(plist, framework_plist);

    plist_text = open(framework_plist).read()
    plist_text = re.sub(r'__MINIMUM_OS_VERSION__', ios, plist_text)
    plist_text = re.sub(r'__BUNDLE_EXECUTABLE__', framework_name, plist_text)
    open(framework_plist, 'w').write(plist_text)
    if device:
      detail.call.call(
          ['lipo', '-remove', 'i386', '-output', framework_lib, framework_lib],
          logging,
          ignore=True
      )
      detail.call.call(
          ['lipo', '-remove', 'x86_64', '-output', framework_lib, framework_lib],
          logging,
          ignore=True
      )
      
    if identity is None:
      identity = 'iPhone Developer';

    sign_cmd = [
        'codesign', '--force', '--sign', identity, framework_dir
    ]
    detail.call.call(sign_cmd, logging)

  print('Framework created: {}'.format(framework_dir))
