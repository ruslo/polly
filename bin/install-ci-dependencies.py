#!/usr/bin/env python3

# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

import argparse
import hashlib
import os
import platform
import requests
import shutil
import stat
import subprocess
import sys
import tarfile
import zipfile

print(
    'Python version: {}.{}'.format(
        sys.version_info.major, sys.version_info.minor
     )
)

parser = argparse.ArgumentParser(
    description='Install dependencies for CI testing'
)

args = parser.parse_args()

class FileToDownload:
  def __init__(self, url, sha1, local_path, unpack_dir):
    self.url = url
    self.sha1 = sha1
    self.local_path = local_path
    self.unpack_dir = unpack_dir

    self.download()
    self.unpack()

  def download(self):
    ok = self.hash_match()
    if ok:
      print('File already downloaded: {}'.format(self.local_path))
    else:
      self.real_file_download()
      assert(self.hash_match() == True)

  def hash_match(self):
    if not os.path.exists(self.local_path):
      print('File not exists: {}'.format(self.local_path))
      return False
    sha1_of_file = hashlib.sha1(open(self.local_path, 'rb').read()).hexdigest()
    ok = (sha1_of_file == self.sha1)
    if ok:
      return True
    else:
      print('SHA1 mismatch for file {}:'.format(self.local_path))
      print('  {} (real)'.format(sha1_of_file))
      print('  {} (expected)'.format(self.sha1))
      return False

  # http://stackoverflow.com/a/16696317/2288008
  def real_file_download(self):
    print('Downloading:\n  {}\n  -> {}'.format(self.url, self.local_path))
    r = requests.get(self.url, stream=True)
    if not r.ok:
      raise Exception('Downloading failed: {}'.format(self.url))
    with open(self.local_path, 'wb') as f:
      for chunk in r.iter_content(chunk_size=16*1024):
        if chunk:
          print('.', end='', flush=True)
          f.write(chunk)
    print('')

  def unpack(self):
    print('Unpacking {}'.format(self.local_path))
    if self.url.endswith('.tar.gz'):
      tar_archive = tarfile.open(self.local_path)
      tar_archive.extractall(path=self.unpack_dir)
      tar_archive.close()
    elif self.url.endswith('.zip'):
      zip_archive = zipfile.ZipFile(self.local_path)
      zip_archive.extractall(path=self.unpack_dir)
      zip_archive.close()
    elif self.url.endswith('.bin'):
      os.chmod(self.local_path, os.stat(self.local_path).st_mode | stat.S_IEXEC)
      last_cwd = os.getcwd()
      os.chdir(self.unpack_dir)
      subprocess.check_call(android_archive_local, stdout=subprocess.DEVNULL)
      os.chdir(last_cwd)
    else:
      sys.exit('Unknown archive format')

### Parse toolchain name

toolchain = os.getenv('TOOLCHAIN')
if toolchain is None:
  toolchain = ''
  print('** WARNING ** Environment variable TOOLCHAIN is empty')

is_android = toolchain.startswith('android-')
is_ninja = toolchain.startswith('ninja-')

### Prepare directories

ci_dir = os.path.join(os.getcwd(), '_ci')

if not os.path.exists(ci_dir):
  os.mkdir(ci_dir)

cmake_archive_local = os.path.join(ci_dir, 'cmake-version.archive')
android_archive_local = os.path.join(ci_dir, 'android.bin')
ninja_archive_local = os.path.join(ci_dir, 'ninja.zip')

expected_files = [
    cmake_archive_local, android_archive_local, ninja_archive_local
]

for i in os.listdir(ci_dir):
  dir_item = os.path.join(ci_dir, i)
  expected = (dir_item in expected_files)
  if os.path.isdir(dir_item):
    print('Removing directory: {}'.format(dir_item))
    shutil.rmtree(dir_item)
  elif not expected:
    print('Removing file: {}'.format(dir_item))
    os.remove(dir_item)

cmake_dir = os.path.join(ci_dir, 'cmake')
ninja_dir = os.path.join(ci_dir, 'ninja')

### Downloading files

if platform.system() == 'Darwin':
  cmake = FileToDownload(
      'https://cmake.org/files/v3.5/cmake-3.5.0-Darwin-x86_64.tar.gz',
      'a63e4c4db2a329b7979ad4bdef23dd3f0c8c163b',
      cmake_archive_local,
      ci_dir
  )
elif platform.system() == 'Linux':
  cmake = FileToDownload(
      'https://cmake.org/files/v3.5/cmake-3.5.0-Linux-x86_64.tar.gz',
      'a815251c29efa8f0614250745cb299890973e42b',
      cmake_archive_local,
      ci_dir
  )
elif platform.system() == 'Windows':
  cmake = FileToDownload(
      'https://cmake.org/files/v3.5/cmake-3.5.0-win32-x86.zip',
      'ed4e1939d246374b0bae724a1a4200fd60e7efe8',
      cmake_archive_local,
      ci_dir
  )
else:
  sys.exit('Unknown system: {}'.format(platform.system()))

if is_android:
  if platform.system() == 'Darwin':
    android = FileToDownload(
        'http://dl.google.com/android/ndk/android-ndk-r10e-darwin-x86_64.bin',
        'b57c2b9213251180dcab794352bfc9a241bf2557',
        android_archive_local,
        ci_dir
    )
  elif platform.system() == 'Linux':
    android = FileToDownload(
        'http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin',
        'c685e5f106f8daa9b5449d0a4f21ee8c0afcb2f6',
        android_archive_local,
        ci_dir
    )
  else:
    sys.exit('Android supported only for Linux and OSX')

if is_ninja:
  ninja = FileToDownload(
      'https://github.com/ninja-build/ninja/releases/download/v1.6.0/ninja-win.zip',
      'e01093f6533818425f8efb0843ced7dcaabea3b2',
      ninja_archive_local,
      ci_dir
  )

### Unify directories

for i in os.listdir(ci_dir):
  src = os.path.join(ci_dir, i)
  if i.startswith('cmake') and os.path.isdir(src):
    macosx_contents = os.path.join(src, 'CMake.app', 'Contents')
    if os.path.isdir(macosx_contents):
      os.rename(macosx_contents, cmake_dir)
    else:
      os.rename(src, cmake_dir)

  if i == 'ninja.exe':
    os.mkdir(ninja_dir)
    os.rename(src, os.path.join(ninja_dir, i))
