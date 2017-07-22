# == Class: panopta::service
# Author: Siebren Zwerver
#

class panopta::service {
  service { 'panopta-agent':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true
  }
}
