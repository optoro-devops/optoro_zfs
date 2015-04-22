name 'optoro_zfs'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'ZFS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.2'

supports 'ubuntu', '=14.04'

depends 'apt', '>= 2.6.1'
depends 'zfs_linux', '>= 2.0.1'
depends 'zfs', '>= 0.0.6'
depends 'zpool', '>= 0.1.0'

conflicts 'zpool', '= 0.0.3'

provides 'optoro_zfs::default'
provides 'optoro_zfs::test'

recipe 'optoro_zfs::default', 'Wrapper around community ZFS cookbook'
recipe 'optoro_zfs::test', 'Test recipe to ensure everything functions as we want it'
