# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

def get(args_toolchain):
  if args_toolchain:
    return args_toolchain
  else:
    return 'default'
