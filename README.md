# Panopta


## Overview

This module implements and manages the Panopta agent and it's modules.

## Module Description

The module allows you to install and configure the Panopta agent easely.
It deploys the manifest file with the companies settings. (optinal)
Installs and configures the Panopta agent, and adds the server into your Panopta account if the manifest is there.

NOTE: Resource tiltes are not being used.

## Usage

Example without usage of the panopta manifest:
```puppet
panopta{ 'title': }
```

Example with usage of the panopta manifest:
```puppet
panopta{ 'title':
  manifest     => true,
  customer_key => 'abc1234',
  fqdn         => '1.2.3.4'
}
```

Enabling a module:
```puppet
panopta::modules {'title':
  nginx     => present,
  nginx_url => 'http://server.example.com/server-status'
}
```

Enabling multiple modules:
```puppet
panopta::modules {'title':
  nginx          => present,
  nginx_url      => 'http://server.example.com/server-status',
  mysql          => present,
  mysql_username => 'panopta',
  mysql_password => 'panopta'
}
```

## List of supported modules with options and examples.

##### cassandra
##### Please note that you only have to enable the cassandra module of you have installed cassandra yourself.
- cassandra_location => 'cassandra installation location'

##### haproxy
- haproxy_socket => 'haproxy socket'

##### jboss
- jboss_username => 'jboss username'
- jboss_password => 'jboss password'
- jobss_url      => 'console url'

##### mysql
- mysql_username => 'mysql username'
- mysql_password => 'mysql password'

##### nginx
- nginx_url => 'nginx status url'

##### oracle
- oracle_username => 'oracle username'
- oracle_password => 'oracle password'
- oracle_sid      => 'oracle database'
- oracle_tns_ip (optional) => 'oracle listen ip'

##### oracleWeblogic
- oracle_wl_username => 'oracle weblogic username'
- oracle_wl_password => 'oracle weblogic password'
- oracle_wl_home     => 'oracle weblogic home'

##### packageUpgrades
- ensure => present
- ensure => absent

##### postgresql
- postgresql_username => 'postgresql username'
- postgresql_password => 'postgresql password'

##### tomcat
- tomcat_username => 'tomcat username'
- tomcat_password => 'tomcat password'
- tomcat_url      => 'tomcat console url'

## Limitations
Supported Operating Systems
* Ubuntu 10.04
* Ubuntu 12.04
* Ubuntu 14.04

* Debian 6
* Debian 7

This Module has been tested on
* Ubuntu 12.04
* Ubuntu 14.04

## TODO
* Testing Ubuntu 10.04
* Testing Debian 6, 7
* Checks to ensure the correct values are given to ensure and ensure like parameters
