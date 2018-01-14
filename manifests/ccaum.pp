user { 'ccaum':
  ensure         => 'present',
  groups         => ['docker','sudo'],
  home           => '/home/ccaum',
  shell          => '/bin/bash',
  purge_ssh_keys => true,
  require        => Class['docker'],
}

ssh_authorized_key { 'ccaum@ettrich.local':
  ensure => present,
  user   => 'ccaum',
  type   => 'ssh-rsa',
  key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCp2vxMiib5zVCBTzWJ+xf62oBBMEk2xhe2zxpuZppFYyQq6x8WJDn/Hoyqhfflzat2G7iBYNMcVD1esK9B+k/iZiNkqfDqmV7NRUy+civS+h7YGy1SlSQ7ftECYxix1TsollNa5p0owYRmxtWZoD6Bs8dxms8QprgRrv/jnv8LDC32Mmi9IfDN8DIGdlABPlh5mlHT/tzIXKOLbe4soBIRr58bMG6LIT+oOrqOAQn+VIo7GqcvX+F8JbLBIx+FZMH5k8TiR+8k2E70zDfimBiyXqebLtBgWP8xBE+ADreLJjtLdd3Na7NDj+tKlwhyhStykcOLguM9LXCbgG66XY6f',
}
