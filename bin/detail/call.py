# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

# Adapted to python3 version of: http://stackoverflow.com/questions/4984428

import os
import platform
import subprocess
import sys
import threading
import time

# Tests:
#
# Windows:
# * Control Panel -> Region -> Administrative -> Current languange for non-Unicode programs: "Russian (Russia)"
# * cd to directory with name like 'привет' and run 'polly.py --verbose'

def tee(infile, discard, logging, console=None):
  """Print `infile` to `files` in a separate thread."""
  def fanout():
    discard_counter = 0
    for line in iter(infile.readline, b''):
      # use the same encoding as stdout/stderr
      s = line.decode(
          encoding=sys.stdout.encoding,
          errors='replace'
      )
      s = s.replace('\r', '')
      s = s.replace('\t', '  ')
      s = s.rstrip() # strip spaces and EOL
      s += '\n' # append stripped EOL back
      logging.write(s)
      if console is None:
        continue
      if discard is None:
        console.write(s)
        continue
      if discard_counter == 0:
        console.write(s)
      discard_counter += 1
      if discard_counter == discard:
        discard_counter = 0
    infile.close()
  t = threading.Thread(target=fanout)
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

  if logging.verbosity != 'silent':
    threads.append(tee(p.stdout, logging.discard, logging, sys.stdout))
    threads.append(tee(p.stderr, logging.discard, logging, sys.stderr))
  else:
    threads.append(tee(p.stdout, logging.discard, logging))
    threads.append(tee(p.stderr, logging.discard, logging))

  for t in threads:
    t.join() # wait for IO completion

  return p.wait()

def call(call_args, logging, cache_file='', ignore=False, sleep=0):
  pretty = 'Execute command: [\n'
  for i in call_args:
    pretty += '  `{}`\n'.format(i)
  pretty += ']\n'
  print(pretty)
  logging.write(pretty)

  # print one line version
  oneline = ''
  for i in call_args:
    oneline += ' "{}"'.format(i)
  oneline = "[{}]>{}\n".format(os.getcwd(), oneline)
  if logging.verbosity != 'silent':
    print(oneline)
  logging.write(oneline)

  x = teed_call(call_args, logging)
  if x == 0 or ignore:
    time.sleep(sleep)
    return
  if os.path.exists(cache_file):
    os.unlink(cache_file)
  logging.log_file.close()
  print('Command exit with status "{}": {}'.format(x, oneline))
  print('Log: {}'.format(logging.log_path))
  logging.print_last_lines()
  print('*** FAILED ***')
  sys.exit(1)
