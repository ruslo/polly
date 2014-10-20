# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

import detail.util
import os
import sys

def get(arch, vs_version):
  vs_path_env = 'VS{}0COMNTOOLS'.format(vs_version)
  vs_path = os.getenv(vs_path_env)
  if not vs_path:
    sys.exit(
        'Environment variable {} is empty, '
        'looks like Visual Studio {} is not installed'.format(
            vs_path_env, vs_version
        )
    )
  vcvarsall_dir = os.path.join(vs_path, '..', '..', 'VC')
  if not os.path.isdir(vcvarsall_dir):
    sys.exit(
        'Directory `{}` not exists '
        '({} environment variable)'.format(vcvarsall_dir, vs_path_env)
    )
  vcvarsall_path = os.path.join(vcvarsall_dir, 'vcvarsall.bat')
  if not os.path.isfile(vcvarsall_path):
    sys.exit(
        'File vcvarsall.bat not found in directory '
        '`{}` ({} environment variable)'.format(vcvarsall_dir, vs_path_env)
    )
  return detail.util.get_environment_from_batch_command([vcvarsall_path, arch])
