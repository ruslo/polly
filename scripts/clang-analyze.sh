#!/bin/bash

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

source "$(dirname "${BASH_SOURCE[0]}")/clang-analyze-common.sh"
analyze_common clang $@
