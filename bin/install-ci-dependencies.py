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
import time
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

  def real_file_download(self):
    max_retry = 3
    for i in range(max_retry):
      try:
        self.real_file_download_once()
        print('Done')
        return
      except Exception as exc:
        print('Exception catched ({}), retry... ({} of {})'.format(exc, i+1, max_retry))
        time.sleep(60)
    sys.exit('Download failed')

  # http://stackoverflow.com/a/16696317/2288008
  def real_file_download_once(self):
    print('Downloading:\n  {}\n  -> {}'.format(self.url, self.local_path))
    r = requests.get(self.url, stream=True)
    if not r.ok:
      raise Exception('Downloading failed: {}'.format(self.url))
    with open(self.local_path, 'wb') as f:
      for chunk in r.iter_content(chunk_size=16*1024):
        if chunk:
          f.write(chunk)

  def unpack(self):
    print('Unpacking {}'.format(self.local_path))
    last_cwd = os.getcwd()
    os.chdir(self.unpack_dir)
    if self.url.endswith('.tar.gz'):
      tar_archive = tarfile.open(self.local_path)
      tar_archive.extractall(path=self.unpack_dir)
      tar_archive.close()
    elif self.url.endswith('.zip'):
      # Can't use ZipFile module because permissions will be lost, see bug:
      # * https://bugs.python.org/issue15795
      subprocess.check_call(['unzip', self.local_path])
    elif self.url.endswith('.bin'):
      os.chmod(self.local_path, os.stat(self.local_path).st_mode | stat.S_IEXEC)
      devnull = open(os.devnull, 'w') # subprocess.DEVNULL is not available for Python 3.2
      subprocess.check_call(self.local_path, stdout=devnull)
    else:
      sys.exit('Unknown archive format')
    os.chdir(last_cwd)

### Parse toolchain name

toolchain = os.getenv('TOOLCHAIN')
if toolchain is None:
  toolchain = ''
  print('** WARNING ** Environment variable TOOLCHAIN is empty')

def get_android_full_version_url():
  if toolchain.startswith('android-ndk-r10e-'):
    if platform.system() == 'Darwin':
      return 'http://dl.google.com/android/ndk/android-ndk-r10e-darwin-x86_64.bin', 'b57c2b9213251180dcab794352bfc9a241bf2557',
    if platform.system() == 'Linux':
      return 'http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin', 'c685e5f106f8daa9b5449d0a4f21ee8c0afcb2f6',
  if toolchain.startswith('android-ndk-r11c-'):
    if platform.system() == 'Darwin':
      return 'http://dl.google.com/android/repository/android-ndk-r11c-darwin-x86_64.zip', '4ce8e7ed8dfe08c5fe58aedf7f46be2a97564696',
    if platform.system() == 'Linux':
      return 'http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip', 'de5ce9bddeee16fb6af2b9117e9566352aa7e279',
  if toolchain.startswith('android-ndk-r15c-'):
    if platform.system() == 'Darwin':
      return 'https://dl.google.com/android/repository/android-ndk-r15c-darwin-x86_64.zip', 'ea4b5d76475db84745aa8828000d009625fc1f98',
    if platform.system() == 'Linux':
      return 'https://dl.google.com/android/repository/android-ndk-r15c-linux-x86_64.zip', '0bf02d4e8b85fd770fd7b9b2cdec57f9441f27a2',
  sys.exit('Android supported only for Linux and OSX')

def get_android_url():
  if not os.getenv('TRAVIS'):
    return get_android_full_version_url()
  if toolchain == 'android-ndk-r10e-api-19-armeabi-v7a-neon':
    if platform.system() == 'Linux':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.0/android-ndk-r10e-arm-linux-androideabi-4.9-gnu-libstdc.-4.9-armeabi-v7a-android-19-arch-arm-Linux.tar.gz', '847177799b0fe4f7480f910bbf1815c3e3fed0da'
    if platform.system() == 'Darwin':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.0/android-ndk-r10e-arm-linux-androideabi-4.9-gnu-libstdc.-4.9-armeabi-v7a-android-19-arch-arm-Darwin.tar.gz', 'e568e9a8f562e7d1bc06f93e6f7cc7f44df3ded2'
  if toolchain == 'android-ndk-r11c-api-19-armeabi-v7a-neon':
    if platform.system() == 'Linux':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.1/android-ndk-r11c-arm-linux-androideabi-4.9-gnu-libstdc.-4.9-armeabi-v7a-android-19-arch-arm-Linux.tar.gz', '2e0da01961e0031bfd7d8db6ce4a15372bd8c3e8'
    if platform.system() == 'Darwin':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.1/android-ndk-r11c-arm-linux-androideabi-4.9-gnu-libstdc.-4.9-armeabi-v7a-android-19-arch-arm-Darwin.tar.gz', '664b3c8104142de2af16f887c19d1b2e618725cb'
  if toolchain == 'android-ndk-r15c-api-21-armeabi-v7a-neon-clang-libcxx':
    if platform.system() == 'Linux':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.1/android-ndk-r15c-arm-linux-androideabi-4.9-llvm-libc.-android-21-arch-arm-Linux.tar.gz', '952403abedc3960b6d6eee35aeed940d935baaea'
    if platform.system() == 'Darwin':
      return 'https://github.com/hunter-packages/android-ndk/releases/download/v1.0.1/android-ndk-r15c-arm-linux-androideabi-4.9-llvm-libc.-android-21-arch-arm-Darwin.tar.gz', '978ef8b724dc3691a128d8f48a8440172478d82b'
  return get_android_full_version_url()

def get_cmake_url():
  if platform.system() == 'Darwin':
    return (
        'https://github.com/ruslo/CMake/releases/download/v3.9.3/cmake-3.9.3-Darwin-x86_64.tar.gz',
        '277375c9d548a5e451f700af488de38718ba07b2'
    )
  elif platform.system() == 'Linux':
    return (
        'https://github.com/ruslo/CMake/releases/download/v3.9.3/cmake-3.9.3-Linux-x86_64.tar.gz',
        'ff1ec7bf201c4c411ffa55c70f4d707d9ab31885'
    )
  elif platform.system() == 'Windows':
    return (
        'https://github.com/ruslo/CMake/releases/download/v3.9.3/cmake-3.9.3-win64-x64.zip',
        'edb0f32dadbbddac01e3991b2ab83a36b4272339'
    )
  else:
    sys.exit('Unknown system: {}'.format(platform.system()))

is_android = toolchain.startswith('android-')
is_ninja = toolchain.startswith('ninja-')

### Prepare directories

ci_dir = os.path.join(os.getcwd(), '_ci')

if not os.path.exists(ci_dir):
  os.mkdir(ci_dir)

cmake_url, cmake_sha1 = get_cmake_url()
cmake_archive_local = cmake_url.split('/')[-1]
cmake_archive_local = os.path.join(ci_dir, cmake_archive_local)

ninja_archive_local = os.path.join(ci_dir, 'ninja.zip')

if is_android:
  url, sha1 = get_android_url()
  android_archive_local = url.split('/')[-1]
else:
  android_archive_local = 'android.bin'
android_archive_local = os.path.join(ci_dir, android_archive_local)

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

# https://cmake.org/download/

FileToDownload(cmake_url, cmake_sha1, cmake_archive_local, ci_dir)

if is_android:
  url, sha1 = get_android_url()
  FileToDownload(url, sha1, android_archive_local, ci_dir)

if is_ninja:
  ninja = FileToDownload(
      'https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-win.zip',
      '637cc6e144f5cc7c6388a30f3c32ad81b2e0442e',
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
