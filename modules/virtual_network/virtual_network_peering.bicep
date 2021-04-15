@description('Nome da Vnet')
param VnetName string
@description('Nome da Vnet remota')
param remoteVnetName string
@description('Resource Group da Vnet remota')
param remoteVnetRg string

resource peering 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  name: '${VnetName}/peering-${VnetName}-to-${remoteVnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(remoteVnetRg, 'Microsoft.Network/virtualNetworks', remoteVnetName)
    }
  }
}

resource rev_peering 'microsoft.network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
  name: '${remoteVnetName}/peering-${remoteVnetName}-to-${VnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', VnetName)
    }
  }
}
