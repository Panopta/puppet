# = Class panopta::modules::cassandra
# Enables the cassandra module of the Panopta Agent
define panopta::modules::cassandra($location = $title) {
	concat {"$::panopta_agent_config":
		ensure				 => present,
		ensure_newline => true
	}

	concat::fragment { 'current config':
		target				 => "$::panopta_agent_config",
		content				 => "$::panopta_current_agent_config",
		order					 => '01'
	}

	concat::fragment { 'cassandra head':
		target	=> "$::panopta_agent_config",
		content	=> '[cassandra]',
		order		=> '01'
	}

	concat::fragment { 'url':
		target	=> "$::panopta_agent_config",
		content	=> "${location}",
		order		=> '02'
	}
}
