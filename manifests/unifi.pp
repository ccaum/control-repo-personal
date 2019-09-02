docker::run { 'unifi':
  image                 => 'jacobalberty/unifi:stable',
  net                   => 'host',
  volumes               => ['/home/ccaum/unifi:/unifi'],
  memory_limit          => '512m',
  env                   => [ "JVM_MAX_THREAD_STACK_SIZE=2048k" ],
  health_check_interval => 30,
}
