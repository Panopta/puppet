# = Class panopta::modules::cassandra
# Enables the cassandra module of the Panopta Agent
define panopta::modules::cassandra($location = $title) {
	concat {"$::panopta_agent_config"
		ensure	=> present
	}

	concat::fragment { 'cassandra head':
		target	=> "$::panopta_agent_config",
		content	=> '[cassabdra]',
		order		=> '01'
	}

	concat::fragment { 'url':
		target	=> "$::panopta_agent_config",
		content	=> "${location}",
		order		=> '02'
	}
}
