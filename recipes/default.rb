#
# Cookbook Name:: traefik
# Recipe:: default
#
# Copyright 2016 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

chef_gem 'toml-rb' do
  version '1.0.0'
end

include_recipe 'traefik::install'
include_recipe 'traefik::service'

directory ::File.dirname(node['traefik']['config_file']) do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

traefik_config node['traefik']['config_file'] do
  config node['traefik']['config']
  notifies :restart, 'service[traefik]' if resource_exists('service[traefik]')
end
