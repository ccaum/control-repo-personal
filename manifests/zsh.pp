package { 'zsh':
  ensure => installed,
}

class { 'ohmyzsh': }
ohmyzsh::install { 'ccaum': }
