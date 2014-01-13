#!/bin/bash

# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

set -x

for x in "$@";
do
  if [ "${x}" == "-c" ];
  then
    temp="`mktemp`"

    # analyze
    clang++ --analyze "$@" 2> "${temp}"

    RESULT=0
    [ "$?" == 0 ] || RESULT=1
    [ -s "${temp}" ] && RESULT=1

    cat "${temp}";
    rm -f "${temp}"

    if [ "${RESULT}" == "1" ];
    then
      exit 1;
    fi
  fi
done

# compile real code
clang++ "$@"
