admin_packages = %w(
  sysstat
  dstat
  screen
  curl
  telnet
  traceroute
  mtr
  zip
  lsof
  strace
  fail2ban
)

case node['platform_family']
when 'debian'
  admin_packages.push('vim')
  admin_packages.push('htop') # htop not available in cent/rhel w/o epel
  node.override['apt']['compile_time_update'] = true
  include_recipe 'apt'
when 'rhel'
  admin_packages.push('vim-minimal')
end

admin_packages.each do | admin_package |
  package admin_package do
    action :install
  end
end

additional_packages = node['additional_packages']
additional_packages.each do | addl_package |
  package addl_package do
    action :install
  end
end
