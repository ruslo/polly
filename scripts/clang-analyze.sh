#!/bin/bash

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

set -x

for x in "$@";
do
  if [ "${x}" == "-c" ];
  then
    temp_out="`mktemp /tmp/polly-clang-analyze.out.XXXXX`"
    temp_bin="`mktemp /tmp/polly-clang-analyze.bin.XXXXX`"

    # analyze
    clang++ --analyze "$@" -o "${temp_bin}" 2> "${temp_out}"

    RESULT=0
    [ "$?" == 0 ] || RESULT=1
    [ -s "${temp_out}" ] && RESULT=1

    cat "${temp_out}";
    rm -f "${temp_out}"
    rm -f "${temp_bin}"

    if [ "${RESULT}" == "1" ];
    then
      exit 1;
    fi
  fi
done

# compile real code
clang++ "$@"
