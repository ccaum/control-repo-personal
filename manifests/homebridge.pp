docker::run { 'homebridge':
  #image                 => 'ccaum/homebridge-ffmpeg',
  image                 => 'oznu/homebridge',
  net                   => 'host',
  privileged            => true,
  health_check_interval => 30,
  volumes => [
    '/home/ccaum/homebridge:/homebridge',
  ],
  require               => Class['docker'],
}
