# = Class panopta
# Configures the panopta agent
class panopta {
  include panopta::config
  include panopta::manifest
  include apt::panopta

  Class['apt::panopta'] ->
  Class['apt::update'] ->
  Class['panopta::manifest'] ->
  package {'panopta-agent':
   ensure          => installed,
   install_options => [ '--force-yes' ]
  } ->
  Class['panopta::config']
}
