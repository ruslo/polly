# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

import os

def get(android_ndk_version):
  varname = 'ANDROID_NDK_{}'.format(android_ndk_version)
  return os.getenv(varname)
