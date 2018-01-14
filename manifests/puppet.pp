file { '/usr/bin/puppet-run':
  ensure  => file,
  mode    => '0755',
  owner   => 0,
  group   => 0,
  content => "#!/bin/bash\n/opt/puppetlabs/bin/puppet apply --modulepath ~ccaum/puppet/modules ~ccaum/puppet/manifests/",
}
