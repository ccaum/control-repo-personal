docker::run { 'unifi':
  image                 => 'jacobalberty/unifi:stable',
  net                   => 'host',
  volumes               => ['/home/ccaum/unifi:/unifi'],
  health_check_interval => 30,
}
