class {'panopta':
  customer_key => 'abc-def-hij',
  server_group => 336981,
  plugins      => {
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
