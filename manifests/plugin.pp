# == Define: panopta::plugins
# Enables and configures the panopta plugins
#

define panopta::plugin (
  Variant[Hash]   $params
) {

  file_line {$title:
    path => $::panopta_agent_config,
    line => "[${title}]"
  }

  $params.each |String $key, String $value| {
    file_line {"${title}-${key}":
      path  => $::panopta_agent_config,
      line  => "${key}=${value}",
      match => "^${key}=",
      after => regsubst($title, '(.*)', '\[\1\]')
    }
  }

}
