include_recipe 'zfs_linux'

if node['optoro_zfs']['zfs_arc_max']
  template '/etc/modprobe.d/zfs-arc-max.conf' do
    owner 'root'
    group 'root'
    mode '0644'
  end
end
