# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import detail.call

def run(build_dir, config, verbose):
  test_command = ['ctest']
  if config:
    test_command.append('-C')
    test_command.append(config)
  if verbose:
    print('Run tests')
    test_command.append('-VV')
  detail.call.call(test_command, verbose)
