# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

function(polly_fatal_error)
  foreach(print_message ${ARGV})
    message("")
    message(${print_message})
    message("")
  endforeach()
  message(FATAL_ERROR "")
endfunction()
