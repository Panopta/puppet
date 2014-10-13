# = Class panopta::modules::tomcat
# Enables the tomcat module of the Panopta Agent
define panopta::modules::tomcat($username, $password, $ip, $port) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'tomcat head':
		target	=> "$::panopta_agent_config",
		content	=> '[tomcat]',
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
		content	=> "console_url = http://${ip}:${port}",
		order		=> '04'
  }
}
