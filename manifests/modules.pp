# == Define: panopta::modules
# Enables and configures the panopta modules
#
# === Options:
# Multiple options are allowed.
#  [cassandra]
#   Importand: Only enable this if you have not installed cassandra through the repository
#   Options: true / false present / absent
#  [cassandra_location]
#   location to the cassandra installation
#
#  [haproxy]
#   true / false / present / absent
#  [haproxy_socket]
#   location to the socket
#
#  [jboss]
#   true / false / present / absent
#  [jboss_username]
#   jboss username
#  [jboss_password]
#   jboss password
#  [jobss_url]
#   jboss console url
#
#  [mysql]
#   true / false / present / absent
#  [mysql_username]
#   MySQL username
#  [mysql_password]
#   MySQL Password
#
#  [nginx]
#   true / false / present / absent
#  [nginx_url]
#   nginx status url page (use http://username:password@server.example.com if you use htaccess auth)
#
#  [oracle]
#   true / false / present / absent
#  [oracle_username]
#   oracle username
#  [oracle_password]
#   oracle password
#  [oracle_sid]
#   databases to monitor. Use comma's to separate multiple databases to monitor
#  [oracle_tns_ip] (optional)
#   which IP oracle is listening on. Default: 127.0.0.1
#
#  [oracleWeblogic]
#   true / false / present / absent
#  [oracle_wl_username]
#   oracle weblogic username
#  [oracle_wl_password]
#   oracle weblogic password
#  [oracle_wl_home]
#   oracle weblogic home
#
#  [packageUpgrades]
#   Important: This allowes the puppet-agent user to do 'sudo apt-get' without password.
#   true / false / present / absent
#
#  [postgresql]
#   true / false / present / absent
#  [postgresql_username]
#   postgresql username
#  [postgresql_password]
#   postgresql password
#
#  [tomcat]
#   true / false / present / absent
#  [tomcat_username]
#   tomcat username
#  [tomcat_password]
#   tomcat password
#  [tomcat_url]
#   tomcat console url

define panopta::modules (
  $cassandra           = undef,
  $cassandra_location  = undef,
  $haproxy             = undef,
  $haproxy_socket      = undef,
  $jboss               = undef,
  $jboss_username      = undef,
  $jboss_password      = undef,
  $jobss_url           = undef,
  $mongodb             = undef,
  $mysql               = undef,
  $mysql_username      = undef,
  $mysql_password      = undef,
  $nginx               = undef,
  $nginx_url           = undef,
  $oracle              = undef,
  $oracle_username     = undef,
  $oracle_password     = undef,
  $oracle_sid          = undef,
  $oracle_tns_ip       = undef,
  $oracleWeblogic      = undef,
  $oracle_wl_username  = undef,
  $oracle_wl_password  = undef,
  $oracle_wl_home      = undef,
  $packageUpgrades     = undef,
  $postgresql          = undef,
  $postgresql_username = undef,
  $postgresql_password = undef,
  $tomcat              = undef,
  $tomcat_username     = undef,
  $tomcat_password     = undef,
  $tomcat_url          = undef
) {

  # Building the default configuration for Panopta
	concat { "$::panopta_agent_config":
		ensure				 => present,
    warn           => true,
		ensure_newline => true
	}

	concat::fragment { 'panopta AgentConfig':
		target				 => "$::panopta_agent_config",
		content				 => '[AgentConfig]',
		order					 => '001'
	}

	concat::fragment { 'panopta version':
		target				 => "$::panopta_agent_config",
		content				 => "version = $::panopta_version",
		order					 => '002'
	}

	concat::fragment { 'panopta customer_key':
		target				 => "$::panopta_agent_config",
		content				 => "customer_key = $::panopta_customer_key",
		order					 => '003'
	}

	concat::fragment { 'panopta agg_url':
		target				 => "$::panopta_agent_config",
		content				 => "agg_url = $::panopta_agg_url",
		order					 => '004'
	}

	concat::fragment { 'panopta server_key':
		target				 => "$::panopta_agent_config",
		content				 => "server_key = $::panopta_server_key",
		order					 => '005'
	}

  if $cassandra != undef {
    concat::fragment { 'cassandra head':
      target  => "$::panopta_agent_config",
      content => '[cassandra]',
      order   => '010'
    }

    concat::fragment { 'cassandra location':
      target  => "$::panopta_agent_config",
      content => "cassandra_installed_location = ${cassandra_location}",
      order   => '011'
    }
  }

  if $haproxy != undef {
    concat::fragment { 'haproxy head':
      target  => "$::panopta_agent_config",
      content => '[haproxy]',
      order   => '020'
    }

    concat::fragment { 'haproxy socket':
      target  => "$::panopta_agent_config",
      content => "socket_cfg_file = ${haproxy_socket}",
      order   => '021'
    }
  }

  if $jboss != undef {
    concat::fragment { 'jboss head':
      target  => "$::panopta_agent_config",
      content => '[jboss]',
      order   => '030'
    }

    concat::fragment { 'jboss username':
      target  => "$::panopta_agent_config",
      content => "username = ${jboss_username}",
      order   => '031'
    }

    concat::fragment { 'jboss password':
      target  => "$::panopta_agent_config",
      content => "password = ${jboss_password}",
      order   => '032'
    }

    concat::fragment { 'jboss url':
      target  => "$::panopta_agent_config",
      content => "console_url = ${jboss_url}",
      order   => '033'
    }
  }

  if $mysql != undef {
    concat::fragment { 'mysql head':
      target  => "$::panopta_agent_config",
      content => '[mysql]',
      order   => '040'
    }

    concat::fragment { 'mysql username':
      target  => "$::panopta_agent_config",
      content => "username = ${mysql_username}",
      order   => '041'
    }

    concat::fragment { 'mysql password':
      target  => "$::panopta_agent_config",
      content => "password = ${mysql_password}",
      order   => '042'
    }
  }

  if $nginx != undef {
    concat::fragment { 'nginx head':
      target  => "$::panopta_agent_config",
      content => '[nginx]',
      order   => '050'
    }

    concat::fragment { 'nginx url':
      target  => "$::panopta_agent_config",
      content => "console_url = ${nginx_url}",
      order   => '051'
    }
  }

  if $oracle != undef {
    concat::fragment { 'oracle head':
      target  => "$::panopta_agent_config",
      content => '[oracle]',
      order   => '060'
    }

    concat::fragment { 'oracle username':
      target  => "$::panopta_agent_config",
      content => "username = ${oracle_username}",
      order   => '061'
    }

    concat::fragment { 'oracle password':
      target  => "$::panopta_agent_config",
      content => "password = ${oracle_password}",
      order   => '062'
    }

    concat::fragment { 'oracle home':
      target  => "$::panopta_agent_config",
      content => "oracle_home = ${oracle_home}",
      order   => '063'
    }

    concat::fragment { 'oracle sid':
      target  => "$::panopta_agent_config",
      content => "oracle_sid = ${oracle_sid}",
      order   => '064'
    }

    if $oracle_tns_ip != undef {
      concat::fragment { 'oracle tns listener ip':
        target  => "$::panopta_agent_config",
        content => "tns_listener_ip = ${oracle_tns_ip}",
        order   => '065'
      }
    }
  }

  if $oracleWeblogic != undef {
    concat::fragment { 'oracle weblogic head':
      target  => "$::panopta_agent_config",
      content => '[weblogic]',
      order   => '070'
    }

    concat::fragment { 'weblogic username':
      target  => "$::panopta_agent_config",
      content => "username = ${oracle_wl_username}",
      order   => '071'
    }

    concat::fragment { 'weblogic password':
      target  => "$::panopta_agent_config",
      content => "password = ${oracle_wl_password}",
      order   => '072'
    }

    concat::fragment { 'weblogic home':
      target  => "$::panopta_agent_config",
      content => "wl_home = ${oracle_wl_home}",
      order   => '073'
    }
  }

  if $postgresql != undef {
    concat::fragment { 'postgresql head':
      target  => "$::panopta_agent_config",
      content => '[postgresql]',
      order   => '080'
    }

    concat::fragment { 'postgresql username':
      target  => "$::panopta_agent_config",
      content => "username = ${postgresql_username}",
      order   => '081'
    }

    concat::fragment { 'postgresql password':
      target  => "$::panopta_agent_config",
      content => "password = ${postgresql_password}",
      order   => '082'
    }
  }

  if $tomcat != undef {
    concat::fragment { 'tomcat head':
      target  => "$::panopta_agent_config",
      content => '[tomcat]',
      order   => '090'
    }

    concat::fragment { 'tomcat username':
      target  => "$::panopta_agent_config",
      content => "username = ${tomcat_username}",
      order   => '091'
    }

    concat::fragment { 'tomcat password':
      target  => "$::panopta_agent_config",
      content => "password = ${tomcat_password}",
      order   => '092'
    }

    concat::fragment { 'tomcat url':
      target  => "$::panopta_agent_config",
      content => "console_url = ${tomcat_url}",
      order   => '093'
    }
  }

  if $packageUpgrades != undef {
    $my_ensure = $packageUpgrades
    file { 'panopta_sudoers':
      ensure  => $my_ensure,
      path    => '/etc/sudoers.d/panopta',
      content => 'panopta-agent ALL=(ALL) NOPASSWD: /usr/bin/apt-get'
    }
  }
}
