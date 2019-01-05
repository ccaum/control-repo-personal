docker_compose { '/home/ccaum/lumas-core-prod/docker-compose.yml':
  ensure  => present,
}

## For FTP account
user { 'garagecamera':
  home  => '/media/GarageCamera',
  shell => '/bin/bash',
}

docker::run { 'homebridge':
  image                 => 'ccaum/homebridge-ffmpeg',
  net                   => 'host',
  privileged            => true,
  health_check_interval => 30,
  volumes               => [
    '/home/ccaum/homebridge:/homebridge'
  ]
}
