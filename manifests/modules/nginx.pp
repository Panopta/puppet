# = Class panopta::modules::nginx
# Enables the nginx module of the Panopta Agent
define panopta::modules::nginx($url = $title) {
	concat {"$::panopta_agent_config":
		ensure	=> present
	}

	concat::fragment { 'nginx head':
		target				 => "$::panopta_agent_config",
		ensure_newline => true,
		content				 => '[nignx]',
		order					 => '01'
	}

	concat::fragment { 'url':
		target	       => "$::panopta_agent_config",
		ensure_newline => true,
		content				 => "${url}",
		order		       => '02'
	}
}
