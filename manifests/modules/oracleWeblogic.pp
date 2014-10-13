# = Class panopta::modules::oracleWeblogic
# Enables the oracleWeblogic module of the Panopta Agent
define panopta::modules::oracleWeblogic($home, $username, $password) {
	concat {"$::panopta_agent_config":
		ensure				 => present,
		ensure_newline => true
	}

	concat::fragment { 'current config':
		target				 => "$::panopta_agent_config",
		content				 => "$::panopta_current_agent_config",
		order					 => '01'
	}

	concat::fragment { 'weblogic head':
		target	=> "$::panopta_agent_config",
		content	=> '[weblogic]',
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

	concat::fragment { 'wl_home':
		target	=> "$::panopta_agent_config",
		content	=> 'wl_home = ${home}',
		order		=> '05'
  }
}
