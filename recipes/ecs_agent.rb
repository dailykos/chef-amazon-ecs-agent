#
# Cookbook Name:: amazon-ecs-agent
# Recipe:: ecs_agent
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
# pull down the latest image
docker_image 'amazon/amazon-ecs-agent'

# start the container and map it to port 8484
docker_container 'amazon-ecs-agent' do
  repo 'amazon/amazon-ecs-agent'
  port '51678:51678'
  restart_policy 'always'
  tag node['amazon-ecs-agent']['tag'],
  env [
    'ECS_LOGFILE=/log/ecs-agent.log',
    "ECS_LOGLEVEL=#{node['amazon-ecs-agent']['log_level']}",
    "ECS_CLUSTER=#{node['amazon-ecs-agent']['cluster']}",
    "ECS_DATADIR=#{node['amazon-ecs-agent']['container_data_folder']}"
  ] + node['amazon-ecs-agent']['docker_additional_env']
  binds [
    "#{node['amazon-ecs-agent']['host_log_folder']}:#{node['amazon-ecs-agent']['container_log_folder']}",
    '/var/run/docker.sock:/var/run/docker.sock',
    "#{node['amazon-ecs-agent']['host_data_folder']}:#{node['amazon-ecs-agent']['container_data_folder']}"
  ] + node['amazon-ecs-agent']['docker_additional_binds']
end
