#!/usr/bin/env python

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import subprocess
import sys

def run():
  toolchain = os.getenv('TOOLCHAIN')
  if not toolchain:
    sys.exit('Environment variable TOOLCHAIN is empty')

  build_type = os.getenv('BUILD_TYPE')
  if not build_type:
    sys.exit('Environment variable BUILD_TYPE is empty')

  build = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'build.py')

  print('Run script: {}'.format(build))
  print('Toolchain: {}'.format(toolchain))
  print('Config: {}'.format(build_type))

  args = [
      sys.executable,
      build,
      '--toolchain',
      toolchain,
      '--config',
      build_type,
      '--verbose',
      '--test'
  ]

  try:
    subprocess.check_call(args)
  except subprocess.CalledProcessError as error:
    print(error)
    print(error.output)
    sys.exit(1)
