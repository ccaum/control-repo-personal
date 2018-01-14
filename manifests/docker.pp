class { 'docker': }
class {'docker::compose':
  ensure => present,
}
