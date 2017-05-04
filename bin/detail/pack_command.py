# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import subprocess

import detail.call

def run(config, logging, cpack_generator, cpack_bin, cmake_bin):
  pack_command = [cpack_bin]
  if os.name == 'nt':
    # use full path to cpack since Chocolatey pack command has the same name
    cmake_list = subprocess.check_output(
        ['where', cmake_bin], universal_newlines=True
    )
    cmake_path = cmake_list.split('\n')[0]
    cpack_path = os.path.join(os.path.dirname(cmake_path), cpack_bin)
    pack_command = [cpack_path]
  if config:
    pack_command.append('-C')
    pack_command.append(config)
  pack_command.append('--verbose')
  if cpack_generator:
    pack_command.append('-G{}'.format(cpack_generator))
  detail.call.call(pack_command, logging)
