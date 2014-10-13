Facter.add('panopta_agent_config') do
  setcode do
    '/etc/panopta-agent/panopta_agent.cfg'
  end
end

Facter.add('panopta_current_agent_config') do
  setcode do
    Facter::Util::Resolution.exec('cat /etc/panopta-agent/panopta_agent.cfg')
  end
end
