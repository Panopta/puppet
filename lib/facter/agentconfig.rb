Facter.add('panopta_agent_config') do
  setcode do
    '/etc/panopta/panopta_agent.cfg'
  end
end
