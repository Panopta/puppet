# Panopta


## Overview

This module implements and manages the Panopta agent and it's modules.

## Module Description

The module allows you to install and configure the Panopta agent easely.
It deploys the manifest file with the companies settings. (optinal)
Installs and configures the Panopta agent, and adds the server into your Panopta account if the manifest is there.

NOTE: Resource tiltes are not being used.

## Usage
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
