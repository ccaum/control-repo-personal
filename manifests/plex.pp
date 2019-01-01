docker::run { 'plex':
  image   => 'plexinc/pms-docker',
  net     => 'host',
  volumes => [
    '/home/ccaum/plex/database:/config',
    '/home/ccaum/plex/transcode/temp:/transcode',
    '/home/ccaum/plex/media:/data',
    '/mnt/media:/media',
  ],
}

mounttab { "/mnt/media":
  ensure   => present,
  device   => "UUID=98426a16-6c87-49ef-8e1c-7017effb1da6",
  fstype   => "xfs",
  options  => ["rw"],
  atboot   => "yes",
  provider => augeas,
}
