# Copyright (c) 2014, Ruslan Baratov
# All rights reserved.

# Add one or more flags to CACHE variable. Skip already existing flags.
function(polly_add_cache_flag var_name flags)
  # Break flags string into CMake list
  set(flags_list ${flags})
  string(REGEX REPLACE "[ \n\t;]+" ";" flags_list ${flags_list})

  foreach(flag ${flags_list})
    # Check flag presense within the list
    string(FIND "${${var_name}}" "${flag}" flag_index)
    if(flag_index EQUAL -1)
      string(LENGTH  "${${var_name}}" var_lng)
      if(var_lng EQUAL 0)
        # beautify: avoid extra space at the end if var_name is empty
        set("${var_name}" "${flag}" CACHE STRING "" FORCE)
      else()
        set("${var_name}" "${flag} ${${var_name}}" CACHE STRING "" FORCE)
      endif()
    endif()
  endforeach()
endfunction()
