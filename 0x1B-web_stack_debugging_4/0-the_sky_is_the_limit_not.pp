# path -> sed -i 's/original/new/g' -> file
exec { 'fix-ulimit':
  path     => 'usr/bin/:/bin/',
  command  => 'sed -i -e "s/15/4096/g" /etc/default/nginx',
  provider => 'shell',
  notify   => Exec['restart-nginx'],
}

exec { 'restart-nginx':
  command  => 'sudo service nginx restart',
  provider => 'shell',
  require  => Exec['fix-ulimit'],
}
