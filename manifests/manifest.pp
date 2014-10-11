# = Class panopta::manifest
# Configures the panopta agent
difine panopta::manifest(
  $customer_key = '',
  $aggregator_url = '',
  $server_group = undef,
  $fqdn = $::ipaddress,
  $server_name = $::fqdn
  ) {

  $manifestFile = '/etc/panopta-agent-manifest'
	concat {"${manifestFile}"
		ensure	=> present
	}

	concat::fragment { 'customer_key':
		target	=> "${manifestFile}",
		content	=> "customer_key = ${customer_key}",
		order		=> '01'
  }

	concat::fragment { 'aggregator_url':
		target	=> "${manifestFile}",
		content	=> "aggregator_url = ${aggregator_url}",
		order		=> '02'
  }

	concat::fragment { 'server_group':
		target	=> "${manifestFile}",
		content	=> "server_group = ${server_group}",
		order		=> '03'
  }

	concat::fragment { 'fqdn':
		target	=> "${manifestFile}",
		content	=> "fqdn = ${fqdn}",
		order		=> '04'
  }

	concat::fragment { 'server_name':
		target	=> "${manifestFile}",
		content	=> "server_name = ${server_name}",
		order		=> '05'
  }
}
