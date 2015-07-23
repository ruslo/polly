# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

# Add flag to CACHE variable. Do nothing if flag already exists.
#
# Note:
#   flags should be added one by one since this function check that
#   substring "flag" already exists in string "var_name".
#
# Bad:
#   polly_add_cache_flag(CMAKE_CXX_FLAGS "-opt1 -opt2 -opt3")
#
# Good:
#   polly_add_cache_flag(CMAKE_CXX_FLAGS "-opt1")
#   polly_add_cache_flag(CMAKE_CXX_FLAGS "-opt2")
#   polly_add_cache_flag(CMAKE_CXX_FLAGS "-opt3")
#
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
