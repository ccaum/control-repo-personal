mounttab { "/mnt/backup":
  ensure   => present,
  device   => "UUID=66a1277a-4964-48e0-a64f-624f1bfc0d04",
  fstype   => "xfs",
  options  => ["rw"],
  atboot   => "yes",
  provider => augeas,
}

file { '/mnt/backup.sh':
  ensure  => file,
  mode    => '0755',
  content => "#!/bin/bash
    mount /mnt/backup;
    rsync -a --delete /mnt/media /mnt/backup/;
    rsync -a --delete /mnt/timemachine /mnt/backup/;
    rsync -a --delete /home/ccaum/lumas-core /mnt/backup/;
    umount /mnt/backup
  ",
  owner   => 0,
  group   => 0,
}

cron { 'backup':
  ensure  => present,
  command => '/mnt/backup.sh',
  user    => root,
  hour    => 9,
  minute  => 0,
}
