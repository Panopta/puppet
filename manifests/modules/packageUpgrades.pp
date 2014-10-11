# = Class panopta::modules::packageUpgrades
# Enables the packageUpgrades module of the Panopta Agent
class panopta::modules::packageUpgrades {
  file {'panopta_sudoers':
    ensure  => present,
    path    => '/etc/sudoers.d/panopta'
    content => 'panopta-agent ALL=(ALL) NOPASSWD: /usr/bin/apt-get'
  }
}
