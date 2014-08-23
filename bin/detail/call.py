# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import subprocess
import sys

# workaround for version less that 3.3
DEVNULL = open(os.devnull, 'w')

def call(call_args, verbose):
  try:
    print('Execute command: [')
    for i in call_args:
      print('  `{}`'.format(i))
    print(']')
    if not verbose:
      subprocess.check_call(
          call_args,
          stdout=DEVNULL,
          stderr=DEVNULL,
          universal_newlines=True,
          env=os.environ
      )
    else:
      subprocess.check_call(
          call_args,
          universal_newlines=True,
          env=os.environ
      )
  except subprocess.CalledProcessError as error:
    print(error)
    print(error.output)
    sys.exit(1)
  except OSError as error:
    print(error)
    sys.exit(1)
