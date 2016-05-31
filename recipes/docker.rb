#
# Cookbook Name:: amazon-ecs-agent
# Recipe:: default
#
# Copyright (C) 2014 Will Salt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'chef-sugar'

package 'apt-transport-https' if ubuntu?

apt_repository 'docker' do
  uri 'https://apt.dockerproject.org/repo'
  trusted true
  components ["ubuntu-#{node['lsb']['codename']}", 'main']
  only_if { ubuntu? }
end

# create the default log folder
directory node['amazon-ecs-agent']['host_log_folder'] do
  mode 0755
  action :create
end

directory node['amazon-ecs-agent']['host_data_folder'] do
  mode 0755
  action :create
end

package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['amazon-ecs-agent']['storage_driver'] == 'aufs' }
end

docker_installation_package 'default' do
  version node['amazon-ecs-agent']['docker']['version']
  action :create
end

# create the docker service
docker_service 'default' do
  storage_driver node['amazon-ecs-agent']['storage_driver']
  log_driver node['amazon-ecs-agent']['docker']['log_driver'] if node['amazon-ecs-agent']['docker']['log_driver']
  log_opts node['amazon-ecs-agent']['docker']['log_opts'] if node['amazon-ecs-agent']['docker']['log_opts']
  bip node['amazon-ecs-agent']['docker']['bip'] if node['amazon-ecs-agent']['docker']['bip']
  action [:create, :start]
end
