# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import sys

import detail.call

def run(generate_command, build_dir, verbose):
  temp_dir = os.path.join(build_dir, '_3rdParty', 'build.py')
  if not os.path.exists(temp_dir):
    os.makedirs(temp_dir)
  saved_arguments_path = os.path.join(temp_dir, 'saved-arguments')

  generate_command_oneline = ' '.join(generate_command)
  cache_file = os.path.join(build_dir, 'CMakeCache.txt')
  if not os.path.exists(cache_file):
    open(saved_arguments_path, 'w').write(generate_command_oneline)
    detail.call.call(generate_command, verbose, cache_file=cache_file)
    return

  # No need to generate project, just check that arguments not changed
  expected = open(saved_arguments_path, 'r').read()
  if expected != generate_command_oneline:
    sys.exit(
        "\n== WARNING ==\n"
        "\nLooks like cmake arguments changed."
        " Please remove build directory by adding '--clear'.\n\n"
        "  Expected: {}\n\n"
        "  Current: {}\n\n".format(expected, generate_command_oneline)
    )
