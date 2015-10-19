# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

import difflib
import os
import sys

import detail.call

def run(generate_command, build_dir, polly_temp_dir, reconfig, logging):
  if not os.path.exists(polly_temp_dir):
    os.makedirs(polly_temp_dir)
  saved_arguments_path = os.path.join(polly_temp_dir, 'saved-arguments')
  cache_file = os.path.join(build_dir, 'CMakeCache.txt')

  generate_command_oneline = ' '.join(
      [ '"{}"'.format(x) for x in generate_command]
  )

  if reconfig or not os.path.exists(saved_arguments_path):
    detail.call.call(generate_command, logging, cache_file=cache_file, sleep=1)
    open(saved_arguments_path, 'w').write(generate_command_oneline)
    return

  # No need to generate project, just check that arguments not changed
  expected = open(saved_arguments_path, 'r').read()
  if expected != generate_command_oneline:
    sys.exit(
        "\n== WARNING ==\n"
        "\nLooks like cmake arguments changed."
        " You have two options to fix it:\n"
        "  * Remove build directory completely"
        " by adding '--clear' (works 100%)\n"
        "  * Run configure again by adding '--reconfigure'"
        " (you must understand how CMake cache variables works/updated)\n\n"
        "{}".format("\n".join(difflib.ndiff([expected], [generate_command_oneline])))
    )
