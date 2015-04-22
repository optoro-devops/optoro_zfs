# Description

ZFS

# Requirements

## Platform:

* Ubuntu (= 14.04)

## Cookbooks:

* apt (>= 2.6.1)
* zfs_linux (>= 2.0.1)
* zfs (>= 0.0.6)
* zpool (>= 0.1.0)
* Conflicts with zpool (= 0.0.3)

# Attributes

*No attributes defined*

# Recipes

* [optoro_zfs::default](#optoro_zfsdefault) - Wrapper around community ZFS cookbook
* [optoro_zfs::test](#optoro_zfstest) - Test recipe to ensure everything functions as we want it

## optoro_zfs::default

Pulls in zfs_linux cookbook

## optoro_zfs::test

This recipe is used to test that we actually can create a zpool or different raids
using fake disks.

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
