docker::run { 'timemachine':
  image                 => 'mbentley/timemachine',
  net                   => 'host',
  health_check_interval => 30,
  env                   => [
    "SHARE_NAME=TimeMachine"
  ],
  volumes               => [
    "/mnt/timemachine:/opt/timemachine"
  ]
}

file { '/mnt/timemachine':
  ensure => directory,
  owner  => 1000,
  group  => 1000,
}

mounttab { "/mnt/timemachine":
  ensure   => present,
  device   => "UUID=74afab4b-379b-4438-a51d-7938fd77d73d",
  fstype   => "xfs",
  options  => ["rw"],
  atboot   => "yes",
  provider => augeas,
}
