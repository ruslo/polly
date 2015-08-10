# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import datetime
import sys
import time

perf_counter_available = (sys.version_info.minor >= 3)

class Job:
  def __init__(self, job_name):
    if perf_counter_available:
      self.start = time.perf_counter()
    else:
      self.start = 0
    self.job_name = job_name
    self.stopped = False

  def stop(self):
    if self.stopped:
      sys.exit('Already stopped')
    self.stopped = True
    if perf_counter_available:
      self.total = time.perf_counter() - self.start
    else:
      self.total = 0

  def result(self):
    if not self.stopped:
      sys.exit("Stop the job before result")
    print(
        '{}: {}s'.format(self.job_name, datetime.timedelta(seconds=self.total))
    )

class Timer:
  def __init__(self):
    self.jobs = []
    self.total = Job('Total')

  def start(self, job_name):
    if job_name == 'Total':
      sys.exit('Name reserved')
    for i in self.jobs:
      if i.job_name == job_name:
        sys.exit('Job already exists: {}'.format(job_name))
    self.jobs.append(Job(job_name))

  def stop(self):
    if len(self.jobs) == 0:
      sys.exit("No jobs to stop")
    self.jobs[-1].stop()

  def result(self):
    if not perf_counter_available:
      print('timer.perf_counter is not available (update to python 3.3+)')
      return
    for i in self.jobs:
      i.result()
    print('-')
    self.total.stop()
    self.total.result()
