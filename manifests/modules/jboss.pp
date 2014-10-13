# = Class panopta::modules::jboss
# Enables the jboss module of the Panopta Agent
define panopta::modules::jboss($username, $password, $url) {
	concat {"$::panopta_agent_config":
		ensure				 => present,
		ensure_newline => true
	}

	concat::fragment { 'current config':
		target				 => "$::panopta_agent_config",
		content				 => "$::panopta_current_agent_config",
		order					 => '01'
	}

	concat::fragment { 'jboss head':
		target	=> "$::panopta_agent_config",
		content	=> '[jboss]',
		order		=> '02'
	}

	concat::fragment { 'username':
		target	=> "$::panopta_agent_config",
		content	=> "username = ${username}",
		order		=> '03'
  }

	concat::fragment { 'password':
		target	=> "$::panopta_agent_config",
		content	=> "password = ${password}",
		order		=> '04'
  }

	concat::fragment { 'url':
		target	=> "$::panopta_agent_config",
		content	=> "console_url = ${url}",
		order		=> '05'
  }
}
