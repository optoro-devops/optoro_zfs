#<
# This recipe is used to test that we actually can create a zpool or different raids
# using fake disks.
#>

include_recipe 'optoro_zfs::default'

bash 'create fake disks' do
  user 'root'
  code <<-EOH
  for i in `seq 1 8`;
  do
    fallocate -l 100M /tmp/zfs-$i
  done
  EOH
end

zpool 'raid0' do
  disks ['/tmp/zfs-5', '/tmp/zfs-6']
end

zpool 'raid10-with-log-mirror' do
  disks ['mirror', '/tmp/zfs-1', '/tmp/zfs-2', 'mirror', '/tmp/zfs-7', '/tmp/zfs-8']
  log_disks ['mirror', '/tmp/zfs-3', '/tmp/zfs-4']
  mountpoint 'none'
  autoexpand true
end

optoro_zfs 'raid10-with-log-mirror/test' do
  atime 'off'
  primarycache 'metadata'
  mountpoint '/test'
end
