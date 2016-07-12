# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.

import tarfile
import platform
import os

def run(install_dir, archives_dir, archive_name, toolchain_name, config):
  if not os.path.exists(archives_dir):
    os.mkdir(archives_dir)

  version = os.getenv('TRAVIS_TAG')
  if version:
    version = '-' + version
  else:
    version = ''

  if config:
    config = '-' + config
  else:
    config = ''

  archive_full_name = archive_name + version + '-' + platform.system() + '-' + toolchain_name + config + '.tar.gz'
  archive_full_name = os.path.join(archives_dir, archive_full_name)

  tar = tarfile.open(archive_full_name, 'w:gz')
  tar.add(install_dir, arcname='.')
  tar.close()

  print('Archive created: {}'.format(archive_full_name))
