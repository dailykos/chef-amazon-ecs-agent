default['amazon-ecs-agent']['host_log_folder'] = '/var/log/ecs'
default['amazon-ecs-agent']['container_log_folder'] = '/log'
default['amazon-ecs-agent']['host_data_folder'] = '/opt/ecs'
default['amazon-ecs-agent']['container_data_folder'] = '/data'
default['amazon-ecs-agent']['log_level'] = 'info'
default['amazon-ecs-agent']['cluster'] = 'default'
default['amazon-ecs-agent']['tag'] = 'latest'
default['amazon-ecs-agent']['storage_driver'] = 'aufs'
default['amazon-ecs-agent']['docker']['version'] = '17.04.0-ce'
default['amazon-ecs-agent']['docker']['log_driver'] = 'awslogs'
default['amazon-ecs-agent']['docker']['log_opts'] = []
default['amazon-ecs-agent']['docker_additional_binds'] = []
default['amazon-ecs-agent']['docker_additional_env'] = [
  "ECS_AVAILABLE_LOGGING_DRIVERS=['syslog','json-file','awslogs']"
]
