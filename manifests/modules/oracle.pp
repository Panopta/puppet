# = Class panopta::modules::oracle
# Enables the oracle module of the Panopta Agent
define panopta::modules::oracle($home, $sid, $username, $password, $tns_listener_ip = undef) {
	concat {"$::panopta_agent_config":
		ensure				 => present,
		ensure_newline => true
	}

	concat::fragment { 'current config':
		target				 => "$::panopta_agent_config",
		content				 => "$::panopta_current_agent_config",
		order					 => '01'
	}

	concat::fragment { 'oracle head':
		target	=> "$::panopta_agent_config",
		content	=> '[oracle]',
		order		=> '02'
	}

	concat::fragment { 'oracle_home':
		target	=> "$::panopta_agent_config",
		content	=> 'oracle_home = ${home}',
		order		=> '03'
  }

	concat::fragment { 'oracle_sid':
		target	=> "$::panopta_agent_config",
		content	=> 'oracle_sid = ${sid}',
		order		=> '04'
	}

	concat::fragment { 'username':
		target	=> "$::panopta_agent_config",
		content	=> "username = ${username}",
		order		=> '05'
  }

	concat::fragment { 'password':
		target	=> "$::panopta_agent_config",
		content	=> "password = $::password",
		order		=> '06'
  }

  if $tns_listener_ip != undef {
  	concat::fragment { 'password':
  		target	=> "$::panopta_agent_config",
  		content	=> "tns_listener_ip = ${tns_listener_ip}",
  		order		=> '07'
    }
  }
}
