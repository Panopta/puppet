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
  $forceInstall = undef
) {

  if ($forceInstall == true) {
    $force_install_ensure = 'present'
  }
  else {
    $force_install_ensure = 'absent'
  }

  if ($manifest == true) {
    $manifestFile = '/etc/panopta-agent-manifest'
    concat { "${manifestFile}":
      ensure				 => present,
      ensure_newline => true,
      before         => File['panopta.list'],
    }

    concat::fragment { 'customer_key':
      target	=> "${manifestFile}",
      content	=> "customer_key = ${customer_key}",
      before  => File['panopta.list'],
      order		=> '01'
    }

    concat::fragment { 'server_group':
      target	=> "${manifestFile}",
      content	=> "server_group = ${server_group}",
      before  => File['panopta.list'],
      order		=> '03'
    }

    if $aggregator_url != undef {
      concat::fragment { 'aggregator_url':
        target	=> "${manifestFile}",
        content	=> "aggregator_url = ${aggregator_url}",
        before  => File['panopta.list'],
        order		=> '02'
      }
    }

    if $fqdn != undef {
      concat::fragment { 'fqdn':
        target	=> "${manifestFile}",
        content	=> "fqdn = ${fqdn}",
        before  => File['panopta.list'],
        order		=> '04'
      }
    }

    if $server_name != undef {
      concat::fragment { 'server_name':
        target	=> "${manifestFile}",
        content	=> "server_name = ${server_name}",
        before  => File['panopta.list'],
        order		=> '05'
      }
    }
  }

  # Not using the apt class here, because this adds the lsbdistcodename which the repo doesn't need
  file { "/etc/apt/apt.conf.d/99auth":       
    ensure  => $force_install_ensure,
    owner   => root,
    group   => root,
    content => 'APT::Get::AllowUnauthenticated yes;',
    mode    => '0644'
  } ->
  file { 'panopta.list':
    ensure  => file,
    path    => '/etc/apt/sources.list.d/panopta.list',
    content => 'deb http://packages.panopta.com/deb stable main'
  } ~>
  exec { 'panopta_apt_update':
    command     => 'apt-get update',
    refreshonly => true,
    returns     => [ 0, 100 ] # Accept error code 0 and 100 so it does continue if apt-get update returns an error 100 (HTTP 404 errors from repositories)
  } ->
  package {'panopta-agent':
    ensure          => installed
  }
}
