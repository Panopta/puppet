# = Class panopta::modules::haproxy
# Enables the haproxy module of the Panopta Agent
define panopta::modules::haproxy($socket = $title) {
	concat {"$::panopta_agent_config":
		ensure				 => present,
		ensure_newline => true
	}

	concat::fragment { 'current config':
		target				 => "$::panopta_agent_config",
		content				 => "$::panopta_current_agent_config",
		order					 => '01'
	}

	concat::fragment { 'haproxy head':
		target	=> "$::panopta_agent_config",
		content	=> '[haproxy]',
		order		=> '02'
	}

	concat::fragment { 'socket':
		target	=> "$::panopta_agent_config",
		content	=> "socket_cfg_file = ${socket}",
		order		=> '03'
  }

}
