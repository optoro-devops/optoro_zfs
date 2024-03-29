include Chef::Mixin::ShellOut

def load_current_resource # rubocop:disable Metrics/MethodLength
  @zfs = Chef::Resource::Zfs.new(new_resource.name)
  @zfs.name(new_resource.name)
  case node['platform']
    # freebsd's zfs doesn't support the 'zone' functionality
  when 'freebsd'
    @managed_props = %w(
      mountpoint recordsize atime compression quota refquota
      reservation refreservation dedup primarycache secondarycache
    )
  else
    @managed_props = %w(
      mountpoint zoned recordsize atime compression quota refquota
      reservation refreservation dedup primarycache secondarycache
    )
  end

  @zfs.info(info?)
  @zfs.current_props(current_props?)
  @zfs.desired_props(desired_props?)
end

action :create do
  unless created?
    Chef::Log.info("Creating zfs #{@zfs.name}")
    shell_out!("zfs create #{@zfs.name}")

    # update properties for new zfs
    @zfs.info(info?)
    @zfs.current_props(current_props?)

    new_resource.updated_by_last_action(true)
  end

  @managed_props.each do |prop|
    next if @zfs.current_props[prop] == @zfs.desired_props[prop]
    Chef::Log.info("Setting #{prop} to #{@zfs.desired_props[prop]} for zfs #{@zfs.name}")
    shell_out!("zfs set #{prop}=#{@zfs.desired_props[prop]} #{@zfs.name}")
    new_resource.updated_by_last_action(true)
  end
end

action :destroy do
  if created?
    Chef::Log.info("Destroying zfs #{@zfs.name}")
    shell_out!("zfs destroy #{@zfs.name}")
    new_resource.updated_by_last_action(true)
  end
end

private

def created?
  @zfs.info.exitstatus.zero?
end

def current_props?
  prop_hash = {}
  @zfs.info.stdout.split("\n").each do |line|
    l = line.split
    prop_hash[l[1]] = l[2]
  end
  prop_hash
end

def info?
  shell_out("zfs get -H all #{@zfs.name}")
end

def desired_props?
  prop_hash = {}

  @managed_props.each do |prop|
    prop_hash[prop] = new_resource.send(prop)
  end
  prop_hash
end
