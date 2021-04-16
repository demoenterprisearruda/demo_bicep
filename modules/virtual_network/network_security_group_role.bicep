
param nsg_name string
param rule_name string
param rule_priority int

@allowed([
  '*'
  'Tcp'
  'Udp'
  'Icmp'
])
param rule_protocol string

@allowed([
  'Allow'
  'Deny'
])
param rule_access string

@allowed([
  'Inbound'
  'Outbound'
])
param rule_direction string
param rule_source_prefix array
param rule_source_port_range string 
param rule_destination_address_prefix array
param rule_destination_port_range string 

resource nsg_rule 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  name: '${nsg_name}/${rule_name}'
  properties: {
    protocol: rule_protocol
    sourcePortRange: rule_source_port_range
    destinationPortRange: rule_destination_port_range
    sourceAddressPrefixes: rule_source_prefix
    destinationAddressPrefixes: rule_destination_address_prefix
    access: rule_access
    priority: rule_priority
    direction: rule_direction
  }
}
