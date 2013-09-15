# == Class: appcleaner
#
# Installs AppCleaner for OS X.
#
# === Parameters:
#
# [*version*] Version of AppCleaner to install
#
# === Examples
#
#  class { 'appcleaner':
#    version => '2.0.8',
#  }
#
# === Authors
#
# Ryan Skoblenick <ryan@skoblenick.com>
#
# === Copyright
#
# Copyright 2013 Ryan Skoblenick.
#
class appcleaner (
  $version = $appcleaner::params::version
) inherits appcleaner::params {
  anchor {'appcleaner::begin': } ->
  class {'appcleaner::install': } ->
  anchor {'appcleaner::end': }
}