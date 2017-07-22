# == Define: panopta::modules
# Enables and configures the panopta modules
#

define panopta::module (
  Variant[Hash]   $params
) {
  include panopta::params

  file_line {$title:
    path => $panopta::params::agent_config,
    line => $title
  }

  $params.each |String $key, String $value| {
    file_line {"${title}-${key}":
      path  => $panopta::params::agent_config,
      line  => "${key}=${value}",
      match => "^${key}=",
      after => regsubst($title, '\[([^\]]+)', '\[\1\\')
    }
  }

}
