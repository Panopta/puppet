# == Define: panopta
# Configures the panopta agent with or without manifest.
#
# === Options:
# [customer_key] (required)
# Undefined  / Your panopta customer key (My Panopta > settings > My Account)
#
# [server_group] (required)
# Undefined / Server group Id (int) (server_group_id parameter of the URL of the server group)
#
# [server_key] (optional)
# Undefined / Server key (int) (server_key unique identifier, defailt seeded_rand($fqdn, 65565)
#
# [aggregator_url] (optional)
# Undefiner / your panopta OnSight appliance. (Ex: https://onsight.example.com)
# Leave empty if you dont have an OnSight appliance.
#
# [server_name] The server name
# Default: $::hostname
#
# [fqdn] (optional)
# This is the IP or hostname where panopta runs his checks on. (FQDN / IP option when adding a server)
# Default: $::fqdn
#
# [plugins]
# Sets panopta plugins
#
# === Actions:
#
# * Creates, if $manifest is set to true, the /etc/panopta-agent-manifest.
# * Adds the panopta repository
# * Installs the panopta-agent package
#
# Usage:
# class {'panopta':
#   customer_key => 'abc-def-hij',
#   manifest     => true,
#   server_group => 336981,
#   plugins      => {
#     'mysql' => {
#       username         => 'username',
#       password         => 'password',
#       extended_metrics => 'Threads_cached, Threads_connected, Threads_created, Threads_running'
#     },
#     'nginx' => {
#       url => 'http://username:password@localhost:8080/server-status'
#     }
#   }
# }

class panopta (
  Variant[String]   $customer_key,
  Optional[String]  $server_key        = 'UNSET',
  Variant[Integer]  $server_group      = 'UNSET',
  Optional[String]  $aggregator_url    = 'UNSET',
  Optional[String]  $interface_mapping = 'UNSET',
  Optional[Integer] $templates         = 0,
  Optional[Array]   $tags              = [],
  Optional[String]  $fqdn              = $::fqdn,
  Optional[String]  $server_name       = $::hostname,
  Optional[Hash]    $plugins           = {}
) {
  include panopta::install

  class {'panopta::manifest':
    customer_key      => $customer_key,
    server_key        => $server_key,
    aggregator_url    => $aggregator_url,
    server_group      => $server_group,
    interface_mapping => $interface_mapping,
    templates         => $templates,
    tags              => $tags,
    fqdn              => $fqdn,
    server_name       => $server_name,
    before            => Class['panopta::install']
  }

  if $plugins {
    $plugins.each |String $plugin, Hash $params| {
      panopta::plugin {$plugin:
        params  => $params,
        require => Package['panopta-agent']
      }
    }
  }

}
