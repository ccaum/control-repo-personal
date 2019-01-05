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
  device   => "UUID=98426a16-6c87-49ef-8e1c-7017effb1da6",
  fstype   => "xfs",
  options  => ["rw"],
  atboot   => "yes",
  provider => augeas,
}
