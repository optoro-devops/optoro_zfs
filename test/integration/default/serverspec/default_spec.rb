# coding: UTF-8

require 'spec_helper'

describe zfs('raid0') do
  it { should exist }
end

describe zfs('raid10-with-log-mirror') do
  it { should exist }
  it { should have_property 'mountpoint' => 'none', 'compression' => 'off', 'atime' => 'on' }
end

describe zfs('raid10-with-log-mirror/test') do
  it { should exist }
  it { should have_property 'atime' => 'off', 'mountpoint' => '/test', 'primarycache' => 'metadata' }
end

describe package('mountall') do
  it { should be_installed }
end

describe file('/etc/cron.daily/zfs-auto-snapshot') do
  its(:content) { should match(/exec zfs-auto-snapshot/) }
end

describe file('/etc/cron.monthly/zfs-auto-snapshot') do
  its(:content) { should match(/exec zfs-auto-snapshot/) }
end
