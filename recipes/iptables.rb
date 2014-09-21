include_recipe 'iptables'
include_recipe 'fail2ban'

# force fail2ban restart when iptables rules are rebuilt
service 'fail2ban' do
  subscribes :restart, 'execute[rebuild-iptables]', :immediately
  action :nothing
end

iptables_rule 'allow_ssh' do
  source 'iptables_rule.erb'
  cookbook 'martinb3-base'
  variables(comment: 'SSH',
            rule: '-A FWR -p tcp -m tcp --dport 22 -j ACCEPT')
end

if node['iptables'] && node['iptables']['rules']
  node['iptables']['rules'].each do |rule|
    rule_name = rule['name']
    rule_comment = rule['comment'] || rule_name
    rule_actual = rule['value']

    rule_enable = true # assume omitting enable means enable=true
    rule_enable = rule['enable'] if rule.key?('enable')

    iptables_rule rule_name do
      source 'iptables_rule.erb'
      cookbook 'martinb3-base'
      variables(comment: rule_comment,
                rule: rule_actual)
      enable rule_enable
    end
  end
end
