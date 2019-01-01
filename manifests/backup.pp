mounttab { "/mnt/backup":
  ensure   => present,
  device   => "UUID=66a1277a-4964-48e0-a64f-624f1bfc0d04",
  fstype   => "xfs",
  options  => ["rw"],
  atboot   => "yes",
  provider => augeas,
}

cron { 'backup-media':
  ensure  => present,
  command => 'rsync -a --delete /mnt/media /mnt/backup/',
  user    => root,
  hour    => 9,
  minute  => 0,
}

cron { 'backup-timemachine':
  ensure  => present,
  command => 'rsync -a --delete /mnt/timemachine /mnt/backup/',
  user    => 'root',
  hour    => 9,
  minute  => 0,
}
