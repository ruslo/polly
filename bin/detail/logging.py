# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import os

class Logging:
  def __init__(self, polly_temp_dir, verbose, discard, tail_N):
    self.verbose = verbose
    self.discard = discard
    self.tail_N = tail_N
    self.log_path = os.path.join(polly_temp_dir, 'log.txt')
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
