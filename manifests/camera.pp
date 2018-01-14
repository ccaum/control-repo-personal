docker_compose { '/home/ccaum/homekit-person-alarm/docker-compose.yml':
  ensure  => present,
}

docker::run { 'homebridge':
  image   => 'ccaum/homebridge-ffmpeg',
  net     => 'host',
  volumes => ['/home/ccaum/homebridge:/homebridge'],
}
