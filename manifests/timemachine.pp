docker::run { 'timemachine':
  image   => 'mbentley/timemachine',
  net     => 'host',
  env     => [
    "SHARE_NAME=TimeMachine"
  ],
  volumes => [
    "/media/timemachine:/opt/timemachine"
  ]
}

file { '/media/timemachine':
  ensure => directory,
  owner  => 1000,
  group  => 1000,
}
