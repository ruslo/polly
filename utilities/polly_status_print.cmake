# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

function(polly_status_print)
  foreach(print_message ${ARGV})
    if(POLLY_STATUS_PRINT OR POLLY_STATUS_DEBUG)
      message(STATUS "[polly] ${print_message}")
    endif()
  endforeach()
endfunction()
