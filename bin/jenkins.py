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

  build = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'build.py')

  print('Run script: {}'.format(build))
  print('Toolchain: {}'.format(toolchain))
  print('Config: {}'.format(config))

  args = [
      sys.executable,
      build,
      '--toolchain',
      toolchain,
      '--config',
      config,
      '--verbose',
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
