# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import os
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

def open(generator, build_dir, verbose):
  if (generator == 'Xcode'):
    detail.call.call(['open', find_project(build_dir, ".xcodeproj")], verbose)
  elif toolchain_entry.generator.is_msvc:
    os.startfile(find_project(build_dir, ".sln"))
  else:
    print("Open skipped (not Xcode or Visual Studio)")
