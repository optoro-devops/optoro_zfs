name 'optoro_zfs'
maintainer 'Optoro'
maintainer 'devops@optoro.com'
license 'MIT'
description 'ZFS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.2'

depends 'apt', '>= 2.6.1'
depends 'zfs_linux', '>= 2.0.1'
depends 'zfs', '>= 0.0.5'
depends 'zpool', '>= 0.0.1'
