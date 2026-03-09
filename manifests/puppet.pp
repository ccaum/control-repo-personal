file { '/usr/bin/puppet-run':
  ensure  => file,
  mode    => '0755',
  owner   => 0,
  group   => 0,
  content => "#!/bin/bash\n/usr/bin/puppet apply --modulepath ~ccaum/puppet/modules ~ccaum/puppet/manifests/",
}

cron { 'puppet-run':
  command => '/usr/bin/puppet-run',
  user    => 'root',
  minute  => '*/10',
  require => File['/usr/bin/puppet-run'],
}
