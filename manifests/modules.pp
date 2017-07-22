# == Define: panopta::modules
# Enables and configures the panopta modules
#

define panopta::modules (
  Variant[Hash]                      $params,
  Variant[Enum['present','abent']]   $ensure,
  Variant[String]                    $module_name = $title,
) {
  include panopta::params

  file_line {"${module_name}":
    ensure => present,
    path   => $panopta::params::agent_config,
    line   => $module_name
  }

  $params.each |String $key, String $value| {
    file_line {"${module_name}-${key}":
      ensure => present,
      path   => $panopta::params::agent_config,
      line   => "${key}=${value}",
      match  => "^${key}=",
      after  => regsubst($module_name, '\[([^\]]+)', '\[\1\\')
    }
  }

}
