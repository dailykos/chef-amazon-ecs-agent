name 'amazon-ecs-agent'
maintainer 'Will Salt'
maintainer_email 'williamejsalt@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures amazon-ecs-agent'
long_description 'Installs/Configures amazon-ecs-agent'
version '1.1.10'

supports 'ubuntu'

depends 'docker', '~> 2.7.1'
depends 'chef-sugar'
depends 'apt'
