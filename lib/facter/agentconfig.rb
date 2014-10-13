Facter.add('panopta_agent_config') do
  setcode do
    '/etc/panopta-agent/panopta_agent.cfg'
  end
end

Facter.add('panopta_server_key') do
  setcode do
    Facter::Util::Resolution.exec("cat /etc/panopta-agent/panopta_agent.cfg |grep server_key |awk '{print $3}'")
  end
end

Facter.add('panopta_agg_url') do
  setcode do
    Facter::Util::Resolution.exec("cat /etc/panopta-agent/panopta_agent.cfg |grep agg_url |awk '{print $3}'")
  end
end

Facter.add('panopta_version') do
  setcode do
    Facter::Util::Resolution.exec("cat /etc/panopta-agent/panopta_agent.cfg |grep version |awk '{print $3}'")
  end
end

Facter.add('panopta_customer_key') do
  setcode do
    Facter::Util::Resolution.exec("cat /etc/panopta-agent/panopta_agent.cfg |grep customer_key |awk '{print $3}'")
  end
end

Facter.add('panopta_customer_key') do
  setcode do
    Facter::Util::Resolution.exec("cat /etc/panopta-agent/panopta_agent.cfg |grep customer_key |awk '{print $3}'")
  end
end

