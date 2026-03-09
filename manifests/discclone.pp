# Clone the DiscClone repository
vcsrepo { '/srv/discclone':
  ensure   => latest,
  provider => git,
  source   => 'https://github.com/Havicish/DiscClone.git',
}

# Data directories for persistent storage
file { ['/srv/discclone/data', '/srv/discclone/data/accounts', '/srv/discclone/data/servers']:
  ensure  => directory,
  owner   => 1000,
  group   => 1000,
  require => Vcsrepo['/srv/discclone'],
}

# Run the docker compose service
docker_compose { 'discclone':
  ensure        => present,
  compose_files => ['/srv/discclone/compose.yaml'],
  require       => [
    Vcsrepo['/srv/discclone'],
    File['/srv/discclone/data/accounts', '/srv/discclone/data/servers'],
    Class['docker'],
  ],
}
