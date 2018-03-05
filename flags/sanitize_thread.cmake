# Copyright (c) 2014-2017, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_FLAGS_SANITIZE_THREAD_CMAKE_)
  return()
else()
  set(POLLY_FLAGS_SANITIZE_THREAD_CMAKE_ 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "-fsanitize=thread")
polly_add_cache_flag(CMAKE_CXX_FLAGS "-g")

polly_add_cache_flag(CMAKE_C_FLAGS "-fsanitize=thread")
polly_add_cache_flag(CMAKE_C_FLAGS "-g")

# NOTE:
#
#   PIE flags removed because it's not a requirement anymore:
#   * https://github.com/google/sanitizers/issues/503#issuecomment-137946595
#
#   With PIE flags sanitizer doesn't work on Ubuntu 14.04/16.04
#   producing runtime error "ThreadSanitizer: unexpected memory mapping":
#   * https://github.com/google/sanitizers/issues/503
