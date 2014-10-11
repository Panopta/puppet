# = Class panopta
# Configures the panopta agent
class panopta {
  apt::source { 'panopta':
    location   => 'http://packages.panopta.com/deb',
    repos      => 'stable main',
  } ->
  package {'panopta-agent':
    ensure          => installed,
    install_options => [ '--force-yes' ]
  }
}
