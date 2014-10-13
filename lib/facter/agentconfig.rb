Facter.add('panopta_agent_config') do
  setcode do
    '/etc/panopta-agent/panopta_agent.cfg'
  end
end
