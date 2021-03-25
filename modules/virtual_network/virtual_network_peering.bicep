param VnetName string
param remoteVnetName string
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