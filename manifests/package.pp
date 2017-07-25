# == Class: panopta::package
# Author: Siebren Zwerver
#

class panopta::package {
  apt::source { 'panopta_repository':
    comment  => 'Panopta repository',
    location => 'http://packages.panopta.com/deb',
    release  => 'stable',
    repos    => 'main',
    key      => {
      'id'     => '1C4698D2DE92D6EE8A769526B7F965468997217A',
      'source' => 'http://packages.panopta.com/panopta.pub'
    }
  }
}
