# = Class panopta::modules::oracle
# Enables the oracle module of the Panopta Agent
define panopta::modules::oracle($home, $sid, $username, $password, $tns_listener_ip = undef) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'oracle head':
		target	=> "$::panopta_agent_config",
		content	=> '[oracle]',
		order		=> '01'
	}

	concat::fragment { 'oracle_home':
		target	=> "$::panopta_agent_config",
		content	=> 'oracle_home = ${home}',
		order		=> '01'
  }

	concat::fragment { 'oracle_sid':
		target	=> "$::panopta_agent_config",
		content	=> 'oracle_sid = ${sid}',
		order		=> '02'
	}

	concat::fragment { 'username':
		target	=> "$::panopta_agent_config",
		content	=> "username = ${username}",
		order		=> '03'
  }

	concat::fragment { 'password':
		target	=> "$::panopta_agent_config",
		content	=> "password = $::password",
		order		=> '04'
  }

  if $tns_listener_ip != undef {
  	concat::fragment { 'password':
  		target	=> "$::panopta_agent_config",
  		content	=> "tns_listener_ip = ${tns_listener_ip}",
  		order		=> '05'
    }
  }
}
