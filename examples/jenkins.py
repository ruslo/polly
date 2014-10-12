#!/usr/bin/env python3

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import subprocess
import sys

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
  build = os.path.join(path, '..', 'bin', 'build.py')

  project_home = os.path.join(path, example)
  if not os.path.exists(project_home):
    sys.exit('Path `{}` not exists'.format(project_home))
  os.chdir(project_home)

  print('Run script: {}'.format(build))
  print('Toolchain: {}'.format(toolchain))
  print('Config: {}'.format(config))
  print('Example: {}'.format(example))

  args = [
      sys.executable,
      build,
      '--toolchain',
      toolchain,
      '--config',
      config,
      '--verbose',
      '--clear',
      '--install',
      '--test'
  ]

  try:
    subprocess.check_call(args)
  except subprocess.CalledProcessError as error:
    print(error)
    print(error.output)
    sys.exit(1)

if __name__ == '__main__':
  run()
