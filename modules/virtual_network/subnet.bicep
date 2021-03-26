@description('Nome da Vnet')
param vnet_name string
@description('Nome da Subnet')
param subnet_name string
@description('Prefixo de Rede da Subnet')
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
