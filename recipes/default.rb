#
# Cookbook Name:: martinb3-default-cookbook
# Recipe:: default
#
# Copyright (C) 2014 Martin Smith
#
#

include_recipe 'user::data_bag'
include_recipe 'martinb3-base::packages'
include_recipe 'martinb3-base::iptables'

include_recipe 'ntp'
include_recipe 'timezone-ii'
include_recipe 'auto-patch'
include_recipe 'chef-client::delete_validation'
include_recipe 'chef-client::config'
include_recipe 'chef-client'
include_recipe 'postfix'
include_recipe 'rsyslog'
include_recipe 'omnibus_updater'
include_recipe 'openssh'
include_recipe 'sudo'

include_recipe 'motd-tail'
motd_tail '/etc/motd' do
  template_source 'motd.erb'
end
