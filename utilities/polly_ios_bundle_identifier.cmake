# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_UTILITIES_POLLY_IOS_BUNDLE_IDENTIFIER_CMAKE_)
  return()
else()
  set(POLLY_UTILITIES_POLLY_IOS_BUNDLE_IDENTIFIER_CMAKE_ 1)
endif()

include(polly_status_debug)

# POLLY_IOS_BUNDLE_IDENTIFIER can be set either through an environment variable 
# or through a regular cmake variable
if (NOT POLLY_IOS_BUNDLE_IDENTIFIER)
  string(COMPARE EQUAL "$ENV{POLLY_IOS_BUNDLE_IDENTIFIER}" "" _is_empty)  
  if(_is_empty)
    set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.example") 
  else()
    set(MACOSX_BUNDLE_GUI_IDENTIFIER $ENV{POLLY_IOS_BUNDLE_IDENTIFIER})
  endif()
else()
  set(MACOSX_BUNDLE_GUI_IDENTIFIER ${POLLY_IOS_BUNDLE_IDENTIFIER})
endif()

polly_status_debug(
    "Using Xcode bundle identifier: ${MACOSX_BUNDLE_GUI_IDENTIFIER}"
)
