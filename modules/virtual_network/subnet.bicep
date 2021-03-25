param vnet_name string
param subnet_name string
param addess_prefix string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' = {
  name: '${vnet_name}/${subnet_name}'
  properties: {
    addressPrefix: '${addess_prefix}'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}