@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
param environment string
param iniciativa string
param regiao string
param identificador string
param location string = resourceGroup().location

//resource param
param vpn_type string
param gateway_type string
param vpn_sku string
param privateip_allocation_method string
param publicip_id string

var network_name = 'cg-${environment}-vgw-${iniciativa}-${regiao}-${identificador}'
var subnet_id = resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', 'cg-${environment}-vnet-${iniciativa}-${regiao}-${identificador}','subnets/GatewaySubnet') 


resource netgateway 'Microsoft.Network/virtualNetworkGateways@2020-06-01' = {
  name: network_name
  location: location
  properties:{
    vpnType: vpn_type
    gatewayType: gateway_type
    activeActive: false
    enableBgp: false
    sku: {
      name: vpn_sku
      tier: vpn_sku
    }

    ipConfigurations:[
      {
        name: 'vnetGatewayConfig'
        properties:{
          privateIPAllocationMethod: privateip_allocation_method
          subnet: {
            id: subnet_id
          }
          publicIPAddress: {
            id: publicip_id
          }
        }
      }
    ]
  }
}