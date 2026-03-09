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

ssh_authorized_key { 'ccaum@ipad':
  ensure => present,
  user   => 'ccaum',
  type   => 'ssh-ed25519',
  key    => 'AAAAC3NzaC1lZDI1NTE5AAAAICegbVM8HVM1SicVmB4SihVHOcFRJ5DX5nd2RL7ScyQ4',
}

ssh_authorized_key { 'ccaum@iphone15promax':
  ensure => present,
  user   => 'ccaum',
  type   => 'ecdsa-sha2-nistp256', 
  key    => 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGKEMY2Nqv4IBj1yCl8zx74dWu6GMqiz8GEesv4oeE97D+WGsKvdKNUQTp9ardzy9uCN9CHbeF/cGBnZalxHXM8=',
}
