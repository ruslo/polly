# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

# Adapted to python3 version of: http://stackoverflow.com/questions/4984428

import os
import subprocess
import sys
import threading

def tee(infile, *files):
  """Print `infile` to `files` in a separate thread."""
  def fanout(infile, *files):
    for line in iter(infile.readline, b''):
      for f in files:
        f.write(line.decode('utf-8'))
    infile.close()
  t = threading.Thread(target=fanout, args=(infile,)+files)
  t.daemon = True
  t.start()
  return t

def teed_call(cmd_args, logging):
  p = subprocess.Popen(
      cmd_args,
      stdout=subprocess.PIPE,
      stderr=subprocess.PIPE,
      env=os.environ,
      bufsize=0
  )
  threads = []

  if logging.verbose:
    threads.append(tee(p.stdout, logging.log_file, sys.stdout))
    threads.append(tee(p.stderr, logging.log_file, sys.stderr))
  else:
    threads.append(tee(p.stdout, logging.log_file))
    threads.append(tee(p.stderr, logging.log_file))

  for t in threads:
    t.join() # wait for IO completion

  return p.wait()

def call(call_args, logging, cache_file=''):
  pretty = 'Execute command: [\n'
  for i in call_args:
    pretty += '  `{}`\n'.format(i)
  pretty += ']\n'
  print(pretty)
  logging.log_file.write(pretty)

  # print one line version
  oneline = ''
  for i in call_args:
    oneline += '"{}" '.format(i)
  oneline = "[{}]> {}\n".format(os.getcwd(), oneline)
  if logging.verbose:
    print(oneline)
  logging.log_file.write(oneline)

  x = teed_call(call_args, logging)
  if x == 0:
    return
  if cache_file:
    os.unlink(cache_file)
  print('Command exit with status "{}": {}'.format(x, oneline))
  print('Log: {}'.format(logging.log_path))
  print('*** FAILED ***')
  sys.exit(1)
