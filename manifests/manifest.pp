# == Class: panopta::manifest
# Author: Siebren Zwerver
#
# Customer Key (required): This identifies you with your Panopta account. By setting this value,
# the agent will automatically add the server to the Panopta control panel.
# You can find this key in the control panel under "My Account" in the "Settings" drop-down.
#
# Server Key: The server key is what allows the agent to communicate with our servers securely.
# You have the option of setting this value, if you like.
# However, we highly recommend that you allow a key to be generated for you and linked to the server in Panopta accordingly.
# Note: all server keys must be unique.
#  Default: seeded_rand('65535', $::fqdn)
#
# Aggregator URL: This controls the API which the Agent communicates with to report its results.
# You should not enter an aggregator URL unless you are using Panopta Onsight as a proxy for servers,
# which dont have outbound public internet access.
# If you are using Panopta Onsight as a proxy and dont know the aggregator URL, please contact support.
#
# Server Group: This controls which group your server gets added to in the control panel.
# Any server template(s) that you have set to be applied to this group will be applied to this server as well.
# The value of the server group is identified by an ID.
# If you go to a servers group in the control panel you can see that groups ID number at the end of that pages URL.
#
# FQDN: This field acts as an override for the hostname that is auto-detected by the agent.
# If you do not include this field then your server will be given its natural fqdn in the control panel.
#
# Server Name: This field lets you set a logical name for this server. That name will identify the server in the control panel.
#
# Interface Mapping: This value is only used if:
# -A template will be auto applied to the server being created
# -That template has place holders for multiple network interfaces. Read more about this here
#
# If your server has multiple network interfaces and the template which is being applied has place holders for multiple network interfaces,
# you have to provide a mapping of the IP for that network interface to the placeholder.
#
# For example, if your server template has the network interface placeholder named private,
# and your server has a network interface with the IP set to 10.100.100.2 you would configure it like this:
#
# interface_mapping = private:10.100.100.2
#
# Templates: This field lets you choose which templates you would like to apply to this server.
# The value of the template is identified by an ID.
# If you go to a server template in the control panel you can see that templates ID number at the end of that page's URL.


class panopta::manifest (
  String           $customer_key,
  Optional[String] $server_key,
  Optional[String] $aggregator_url,
  Optional[String] $server_group,
  Optional[String] $interface_mapping,
  Optional[String] $templates,
  Optional[Array]  $tags,
  Optional[String] $fqdn        = $::fqdn,
  Optional[String] $server_name = $::hostname
  ) {

    case $server_key {
      undef: {
        $real_server_key = seeded_rand('65565', $::fqdn)
      }
      false: {
        $real_server_key = 'UNSET'
      }
      String: {
        $real_server_key = $server_key
      }
      default: {
        $real_server_key = seeded_rand('65565', $::fqdn)
      }
    }

    if $real_server_key != 'UNSET' {
      notify{ "Server key for: ${server_name} (${fqdn})": message => $real_server_key}
    }

    file { 'panopta-agent-manifest':
      ensure  => file,
      path    => '/etc/panopta-agent-manifest',
      mode    => '0644',
      owner   => root,
      group   => root,
      content => template('panopta/panopta-agent-manifest.erb')
    }
}
