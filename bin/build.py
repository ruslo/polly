#!/usr/bin/env python3

# Copyright (c) 2014-2015, Ruslan Baratov
# All rights reserved.

# Note: build.py has been renamed to polly.py.

from os.path import abspath, dirname, join
exec(open(join(dirname(abspath(__file__)), 'polly.py'), 'r').read())
