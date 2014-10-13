#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import shutil
import subprocess
import sys
import tempfile

def run():
  toolchain = os.getenv('TOOLCHAIN')
  if not toolchain:
    sys.exit('Environment variable TOOLCHAIN is empty')

  config = os.getenv('CONFIG')
  if not config:
    sys.exit('Environment variable CONFIG is empty')

  example = os.getenv('EXAMPLE')
  if not example:
    sys.exit('Environment variable EXAMPLE is empty')

  path = os.path.dirname(os.path.realpath(__file__))
  if not os.path.isabs(path):
    path = os.path.abspath(path)

  build = os.path.join(path, '..', 'bin', 'build.py')

  project_home = os.path.join(path, example)
  if not os.path.exists(project_home):
    sys.exit('Path `{}` not exists'.format(project_home))
  os.chdir(project_home)

  build_dir = os.path.join(os.getcwd(), '_builds')
  if os.name == 'nt':
    hunter_junctions = os.getenv('HUNTER_JUNCTIONS')
    if hunter_junctions:
      build_dir = tempfile.mkdtemp(dir=hunter_junctions)

  print('Run script: {}'.format(build))
  print('Toolchain: {}'.format(toolchain))
  print('Config: {}'.format(config))
  print('Example: {}'.format(example))

  os.makedirs(build_dir, exist_ok=True)
  os.chdir(build_dir)

  args = [
      sys.executable,
      build,
      '--toolchain',
      toolchain,
      '--config',
      config,
      '--home',
      project_home,
      '--verbose',
      '--clear',
      '--install',
      '--test'
  ]

  try:
    subprocess.check_call(args)
    shutil.rmtree(build_dir, ignore_errors=True)
  except subprocess.CalledProcessError as error:
    print(error)
    print(error.output)
    sys.exit(1)

if __name__ == '__main__':
  run()
