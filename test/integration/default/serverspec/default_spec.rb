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
  it { should have_property 'atime' => 'off', 'mountpoint' => '/test' }
end

describe package('mountall') do
  it { should be_installed }
end
