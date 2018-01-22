docker::run { 'plex':
  image   => 'plexinc/pms-docker',
  net     => 'host',
  volumes => [
    '/home/ccaum/plex/database:/config',
    '/home/ccaum/plex/transcode/temp:/transcode',
    '/home/ccaum/plex/media:/data',
    '/media:/media',
  ],
}

mounttab { "/media":
  ensure   => present,
  device   => "/dev/disk/by-label/Media",
  fstype   => "hfsplus",
  options  => "rw",
  atboot   => "yes",
  provider => augeas,
}
