# Panopta


## Overview

This module implements and manages the Panopta agent and it's modules.

## Module Description

The module allows you to install and configure the Panopta agent easely.
It deploys the manifest file with the companies settings.
Installs and configures the Panopta agent, and adds the server into your Panopta account.

NOTE: Resource tiltes are not being used.

## Variables:
`$customer_key`  
`String` Required: you can find this at: my.panopta.com > My Account  
`$server_key`  
`String` Optional, defaults to `seeded_rand($::fqdn, 65565)`  
`$server_group`  
`Integer` Optional, Default: 0 (unset)
`$aggregator_url`  
`String` Default: unset, do not use unless it needs to proxy through the OnSight appliance.  
`$interface_mapping`  
`Integer` Default: unset  
`$templates`
`String` Optional, Default: 0 (unset)
`$tags`
`Array` Optional, Default: empty  
`$fqdn`
`String` Optional, Default: `$::fqdn`  
`$server_name`  
`String` Optional, Default: `$::hostname`  
`$plugins`
`Hash` Optional, Default: empty

## Examples:
###Example with only required parameters
```puppet
class {'panopta':
  customer_key => 'abc-def-hij',
  server_group => 336981
}
```

###Enabling a module:
```puppet
class {'panopta':
  customer_key => 'abc-def-hij',
  server_group => 336981,
  modules      => {
    'mysql' => {
      username         => 'username',
      password         => 'password',
      extended_metrics => 'Threads_cached, Threads_connected, Threads_created, Threads_running'
    },
  }
}
```

###Enabling multiple modules:
```puppet
class {'panopta':
  customer_key => 'abc-def-hij',
  server_group => 336981,
  modules      => {
    'mysql' => {
      username         => 'username',
      password         => 'password',
      extended_metrics => 'Threads_cached, Threads_connected, Threads_created, Threads_running'
    },
    'nginx' => {
      url => 'http://username:password@localhost:8080/server-status'
    }
  }
}
```

## List of supported plugins with options and examples.
Please refer to the documentation of Panopta: http://help.panopta.com/v1.0/docs/plugins

## Limitations
Supported Operating Systems

* Ubuntu 10.04
* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 16.04

* Debian 6
* Debian 7
* Debian 8

This Module has been tested on

* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 16.04
* Debian 6
* Debian 7
* Debian 8
