# = Class panopta::modules::oracleWeblogic
# Enables the oracleWeblogic module of the Panopta Agent
define panopta::modules::oracleWeblogic($home, $username, $password) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'weblogic head':
		target	=> "$::panopta_agent_config",
		content	=> '[weblogic]',
		order		=> '01'
	}

	concat::fragment { 'username':
		target	=> "$::panopta_agent_config",
		content	=> "username = ${username}",
		order		=> '02'
  }

	concat::fragment { 'password':
		target	=> "$::panopta_agent_config",
		content	=> "password = $::password",
		order		=> '03'
  }

	concat::fragment { 'wl_home':
		target	=> "$::panopta_agent_config",
		content	=> 'wl_home = ${home}',
		order		=> '04'
  }
}
