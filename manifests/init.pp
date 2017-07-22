# == Define: panopta
# Configures the panopta agent with or without manifest.
#
# === Options:
# [manifest] (required)
# true/present/false/absent (bool)
#
# [customer_key] (required)
# Undefined  / Your panopta customer key (My Panopta > settings > My Account)
#
# [server_group] (required)
# Undefined / Server group Id (int) (server_group_id parameter of the URL of the server group)
#
# [aggregator_url] (optional)
# Undefiner / your panopta onsight appliance. (Ex: https://onsight.example.
#
# [fqdn] (optional)
# This is the IP or hostname where panopta runs his checks on. (FQDN / IP option when adding a server)
# Recomended: $::ipaddress fact, or IP where you want to run your checks on.
#
# [server_name] (optional)
# This is the server name label.
#
# [forceInstall]
# true / false
# See README
#
# === Actions:
#
# * Creates, if $manifest is set to true, the /etc/panopta-agent-manifest.
# * Adds the panopta repository
# * Installs the panopta-agent package with --force-yes installation argument

class panopta (
  Variant[String]  $customer_key,
  Variant[Integer] $server_group,
  Optional[String] $server_key        = 'UNSET',
  Optional[String] $aggregator_url    = 'UNSET',
  Optional[String] $interface_mapping = 'UNSET',
  Optional[String] $templates         = 'UNSET',
  Optional[Array]  $tags              = [],
  Optional[String] $fqdn              = $::fqdn,
  Optional[String] $server_name       = $::hostname,
  Variant[Boolean] $manifest          = false,
) {
  include panopta::install

  if $manifest == true {
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
  }

}
