# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import sys

class Target:
  def __init__(self):
    self.name = ''

  def add(self, condition, name):
    if not condition:
      return
    if not name:
      sys.exit('No name for target')
    if not self.name:
      self.name = name
      return
    if self.name == name:
      return
    sys.exit(
        "Can't add target `{}` since another target defined: `{}`".format(
            name, self.name
        )
    )

  def args(self):
    if self.name:
      return ['--target', self.name]
    else:
      return []
