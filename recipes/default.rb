#<
## Pulls in zfs_linux cookbook & set zfs-arc-max if appropriate
#>

# create limits before installing to avoid having to reload after
template '/etc/modprobe.d/zfs-arc-max.conf' do
  owner 'root'
  group 'root'
  mode '0644'
  only_if { node['optoro_zfs']['zfs_arc_max'] }
end

include_recipe 'zfs_linux'
include_recipe 'zfs_linux::auto-scrub'
package 'mountall'
