# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

function(polly_status_debug)
  foreach(print_message ${ARGV})
    if(POLLY_STATUS_DEBUG)
      message(STATUS "[polly *** DEBUG ***] ${print_message}")
    endif()
  endforeach()
endfunction()
