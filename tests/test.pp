class {'panopta':
  customer_key => 'abc-def-hij',
  manifest     => true,
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
