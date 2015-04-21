# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
import subprocess
import sys

import detail.call

def find_project(directory, extension):
  for file in os.listdir(directory):
    if file.endswith(extension):
      project_path = os.path.join(directory, file)
      print("Open project: {}".format(project_path))
      return project_path
  sys.exit(
      "Project with extension `{}` not found in `{}`".format(
          extension,
          directory
      )
  )

def open(toolchain, build_dir, logging):
  if toolchain.is_xcode:
    args = ['open']
    dev_root = ''
    if toolchain.ios_version:
      dev_root = detail.ios_dev_root.get(toolchain.ios_version)
    if not dev_root:
      dev_root = subprocess.check_output(
          ['xcode-select', '--print-path'], universal_newlines=True
      ).split('\n')[0]
    args.append('-a')
    args.append(os.path.join(dev_root, '..', '..'))
    args.append(find_project(build_dir, ".xcodeproj"))
    detail.call.call(args, logging)
  elif toolchain.is_msvc:
    os.startfile(find_project(build_dir, ".sln"))
  else:
    print("Open skipped (not Xcode or Visual Studio)")
