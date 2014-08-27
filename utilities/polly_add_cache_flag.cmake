# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

# Add flag to CACHE variable. Do nothing if flag already exists.
function(polly_add_cache_flag var_name flag)
  set(spaced_string " ${${var_name}} ")
  string(FIND "${spaced_string}" " ${flag} " flag_index)
  if(NOT flag_index EQUAL -1)
    return()
  endif()
  string(COMPARE EQUAL "" "${${var_name}}" is_empty)
  if(is_empty)
    # beautify: avoid extra space at the end if var_name is empty
    set("${var_name}" "${flag}" CACHE STRING "" FORCE)
  else()
    set("${var_name}" "${flag} ${${var_name}}" CACHE STRING "" FORCE)
  endif()
endfunction()
