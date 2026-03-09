#docker_compose { '/home/ccaum/lumas-core-prod/docker-compose.yml':
#  ensure  => present,
#}


docker::run { 'scrypted':
  image      => 'koush/scrypted',
  ensure     => absent,
  privileged => false,
  net        => host,
  restart    => 'always',
  volumes    => [
    '/home/ccaum/.scrypted/volume:/server/volume'
  ],
  require => Class['docker'],
}
