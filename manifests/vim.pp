vcsrepo { '/home/ccaum/.vim':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/ccaum/ccaum-vim.git',
}

file { '/home/ccaum/.vimrc':
  ensure  => symlink,
  target  => '/home/ccaum/.vim/vimrc',
  require => Vcsrepo['/home/ccaum/.vim'],
}
