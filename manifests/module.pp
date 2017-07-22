# == Define: panopta::modules
# Enables and configures the panopta modules
#

define panopta::module (
  Variant[Hash]                      $params,
  Variant[Enum['present','abent']]   $ensure,
  Variant[String]                    $module_name = $title,
) {
  include panopta::params

  file_line {$module_name:
    path   => $panopta::params::agent_config,
    line   => $module_name
  }

  $params.each |String $key, String $value| {
    file_line {"${module_name}-${key}":
      path   => $panopta::params::agent_config,
      line   => "${key}=${value}",
      match  => "^${key}=",
      after  => regsubst($module_name, '\[([^\]]+)', '\[\1\\')
    }
  }

}
