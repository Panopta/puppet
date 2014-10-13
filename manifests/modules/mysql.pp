# = Class panopta::modules::mysql
# Enables the mysql module of the Panopta Agent
define panopta::modules::mysql($username, $password) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'mysql head':
		target	=> "$::panopta_agent_config",
		content	=> '[mysql]',
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
}
