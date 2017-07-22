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
  String            $customer_key,
  Optional[String]  $server_key,
  Optional[String]  $aggregator_url,
  Optional[String]  $server_group,
  Optional[String]  $interface_mapping,
  Optional[String]  $templates,
  Optional[Array]   $tags,
  Optional[String]  $fqdn        = $::fqdn,
  Optional[String]  $server_name = $::hostname,
  Optional[Boolean] $manifest = false,
) {
  include panopta::install

  if $manifest == true {
    include 'panopta':manifest
    Class['panopta::manifest'] { before => Class['panopta::install'] }
  }

}
