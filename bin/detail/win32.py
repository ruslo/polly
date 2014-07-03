import ctypes
from ctypes import wintypes

_GetShortPathNameW = ctypes.windll.kernel32.GetShortPathNameW
_GetShortPathNameW.argtypes = [wintypes.LPCWSTR, wintypes.LPWSTR, wintypes.DWORD]
_GetShortPathNameW.restype = wintypes.DWORD

def get_short_path_name(long_name):
  """
  Gets the short path name of a given long path.
  http://stackoverflow.com/a/23598461/200291
  """
  output_buf_size = 0
  while True:
    print("begin output_buf_size: {}".format(output_buf_size))
    output_buf = ctypes.create_unicode_buffer(output_buf_size)
    needed = _GetShortPathNameW(long_name, output_buf, output_buf_size)
    print("Needed: {}".format(needed))
    if output_buf_size >= needed:
      return output_buf.value
    else:
      output_buf_size = needed
