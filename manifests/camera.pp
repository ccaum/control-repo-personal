docker_compose { '/home/ccaum/homekit-person-alarm/docker-compose.yml':
  ensure  => present,
}

## For FTP account
user { 'garagecamera':
  home  => '/media/GarageCamera',
  shell => '/bin/bash',
}

docker_compose { '/media/GarageCamera/Shinobi/docker-compose.yml':
  ensure => present,
}
