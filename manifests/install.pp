# == Class: appcleaner::install
#
# Installs AppCleaner for OS X.
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class appcleaner::install {
  $version = $appcleaner::version

  case $::kernel {
    'Darwin': {
       $source = "http://www.freemacsoft.net/downloads/AppCleaner_${version}.zip"
    }
    default: {
      fail("Unsupported Kernel: ${::kernel} operatingsystem: ${::operatingsystem}")
    }
  }

  Exec {
    cwd => '/tmp',
    path => '/usr/bin:/bin',
    onlyif => "test ! -f /var/db/.puppet_appzip_installed_appcleaner-${version}",
  }

  exec {'appcleaner-download':
    command => "curl -o AppCleaner.zip -C - -k -L -s --url ${source}",
  }
  ->
  exec {'appcleaner-install':
    command => "unzip -o AppCleaner.zip -d /Applications",
  }
  ->
  file {"/var/db/.puppet_appzip_installed_appcleaner-${version}":
    ensure => file,
    content => "name:'appcleaner'\nsource:'${source}'",
    owner => 'root',
    group => 'wheel',
    mode => '0644',
  }
  ->
  file {'/tmp/AppCleaner.zip':
    ensure => absent,
  }
}