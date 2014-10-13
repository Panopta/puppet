# = Class panopta::modules::postgresql
# Enables the postgresql module of the Panopta Agent
define panopta::modules::postgresql($username, $password) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'psql head':
		target	=> "$::panopta_agent_config",
		content	=> '[postgresql]',
		order		=> '01'
	}

	concat::fragment { 'username':
		target	=> "$::panopta_agent_config",
		content	=> "username = ${username}",
		order		=> '02'
  }

	concat::fragment { 'password':
		target	=> "$::panopta_agent_config",
		content	=> "password = ${password}",
		order		=> '03'
  }

}
