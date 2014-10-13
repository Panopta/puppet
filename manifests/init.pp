# == Define: panopta
# Configures the panopta agent with or without manifest.
#
# === Options:
# [manifest]
# true/false (bool)
#
# [customer_key]
# Undefined  / Your panopta customer key (My Panopta > settings > My Account)
#
# [server_group]
# Undefined / Server group Id (int) (server_group_id parameter of the URL of the server group)
#
# [aggregator_url]
# Undefiner / your panopta onsight appliance. (Ex: https://onsight.example.
#
# [fqdn]
# This is the IP or hostname where panopta runs his checks on. (FQDN / IP option when adding a server)
# Recomended: $::ipaddress fact, or IP where you want to run your checks on.
#
# [server_name]
# This is the server name label.
#
# === Actions:
# 
# * Creates, if $manifest is set to true, the /etc/panopta-agent-manifest.
# * Adds the panopta repository
# * Installs the panopta-agent package with --force-yes installation argument

define panopta (
  $manifest = false,
  $customer_key = undef,
  $server_group = undef,
  $aggregator_url = undef,
  $fqdn = undef,
  $server_name = undef,
) {

  if $manifest == true {
    notify{'setting manifest': }
    $manifestFile = '/etc/panopta-agent-manifest'
    concat { "${manifestFile}":
      ensure				 => present,
      ensure_newline => true
    }

    concat::fragment { 'customer_key':
      target	=> "${manifestFile}",
      content	=> "customer_key = ${customer_key}",
      order		=> '01'
    }

    concat::fragment { 'server_group':
      target	=> "${manifestFile}",
      content	=> "server_group = ${server_group}",
      order		=> '03'
    }

    if $aggregator_url != undef {
      concat::fragment { 'aggregator_url':
        target	=> "${manifestFile}",
        content	=> "aggregator_url = ${aggregator_url}",
        order		=> '02'
      }
    }

    if $fqdn != undef {
      concat::fragment { 'fqdn':
        target	=> "${manifestFile}",
        content	=> "fqdn = ${fqdn}",
        order		=> '04'
      }
    }

    if $server_name != undef {
      concat::fragment { 'server_name':
        target	=> "${manifestFile}",
        content	=> "server_name = ${server_name}",
        order		=> '05'
      }
    }
  }

  apt::source { 'panopta':
    location   => 'http://packages.panopta.com/deb',
    repos      => 'stable main',
  } ->
  package {'panopta-agent':
    ensure          => installed,
    install_options => [ '--force-yes' ]
  }
}
