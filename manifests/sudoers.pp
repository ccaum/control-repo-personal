sudo::sudoers { 'ccaum':
  ensure   => 'present',
  users    => ['ccaum'],
  hosts    => ['ALL'],
  runas    => ['root'],
  cmnds    => ['ALL'],
  tags     => ['NOPASSWD'],
  defaults => [ 'env_keep += "SSH_AUTH_SOCK"' ]
}
