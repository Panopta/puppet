# = Class panopta::manifest
# Configures the panopta agent
difine panopta::manifest(
  $customer_key = '',
  $server_group = undef,
  $aggregator_url = undef
  $fqdn = undef,
  $server_name = undef,
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

	concat::fragment { 'server_group':
		target	=> "${manifestFile}",
		content	=> "server_group = ${server_group}",
		order		=> '03'
  }

  if ${aggregator_url} != undef {
  	concat::fragment { 'aggregator_url':
  		target	=> "${manifestFile}",
  		content	=> "aggregator_url = ${aggregator_url}",
  		order		=> '02'
    }
  }

  if ${fqdn} != undef {
  	concat::fragment { 'fqdn':
  		target	=> "${manifestFile}",
  		content	=> "fqdn = ${fqdn}",
  		order		=> '04'
    }
  }

  if ${server_name} != undef {
  	concat::fragment { 'server_name':
  		target	=> "${manifestFile}",
  		content	=> "server_name = ${server_name}",
  		order		=> '05'
    }
  }
}
