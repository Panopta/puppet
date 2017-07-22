# == Class: panopta::install
# Author: Siebren Zwerver
#

class panopta::install {
  include panopta::package

  package { 'panopta-agent':
    ensure  => installed,
    require => Class['panopta::package']
  }
}
