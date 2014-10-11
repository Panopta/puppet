# = Class panopta::modules::jboss
# Enables the jboss module of the Panopta Agent
define panopta::modules::jboss($username, $password, $url) {
	concat {"$::panopta_agent_config"
		ensure	=> present
	}

	concat::fragment { 'jboss head':
		target	=> "$::panopta_agent_config",
		content	=> '[jboss]',
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

	concat::fragment { 'url':
		target	=> "$::panopta_agent_config",
		content	=> "console_url = ${url}",
		order		=> '04'
  }
}
