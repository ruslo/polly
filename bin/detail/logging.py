# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import os
import sys

class Logging:
  def __init__(self, cdir, verbose, discard, tail_N):
    self.verbose = verbose
    self.discard = discard
    self.tail_N = tail_N

    log_dir = os.path.join(cdir, '_logs', 'polly')
    if not os.path.exists(log_dir):
      os.makedirs(log_dir)

    for i in range(1000):
      try_name = 'log-{}.txt'.format(i)
      try_path = os.path.join(log_dir, try_name)
      if not os.path.exists(try_path):
        self.log_path = try_path
        break
    else:
      sys.exit(
          'Please clean-up your logs in directory: {}'.format(log_dir)
      )

    self.log_file = open(self.log_path, 'w')

  def print_last_lines(self):
    if self.tail_N is None:
      return
    lines = open(self.log_path, 'r').readlines()
    tail = lines[-self.tail_N:]
    print('Last {} lines\n'.format(self.tail_N))
    print('-' * 80)
    for i in tail:
      print('    {}'.format(i), end='')
    print('-' * 80)
