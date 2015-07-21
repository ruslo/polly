# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import detail.call

def run(build_dir, config, logging,test_xml):
  test_command = ['ctest']
  if test_xml:
    test_command.append('-T')
    test_command.append(test_xml)
  if config:
    test_command.append('-C')
    test_command.append(config)
  print('Run tests')
  test_command.append('-VV')
  detail.call.call(test_command, logging)
