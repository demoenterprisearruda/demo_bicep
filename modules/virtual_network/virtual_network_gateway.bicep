@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
@description('Sigla do Ambiente onde o recurso está rodando')
param environment string
@allowed([
  'spk'
  'hub'
])
@description('Sigla de 3 digitos que identifica a iniciativa do recurso')
param iniciativa string
@allowed([
  'use2'
  'brs1'
  'usc1'
])
@description('Sigla de 3 digitos que identifica a região do recurso')
param regiao string
@description('ID numérico de 3 digitos que compôe o nome do recurso')
param identificador string
param location string = resourceGroup().location

//resource param
@allowed([
  'RouteBased'
])
@description('Tipo da VPN')
param vpn_type string

@allowed([
  'Vpn'
  'ExpressRoute'
])
@description('Tipo de Gateway')
param gateway_type string
@allowed([
  'VpnGw1'
])
@description('SKU da VPN')
param vpn_sku string
@allowed([
  'Dynamic'
])
@description('Metodo de alocação de IP')
param privateip_allocation_method string
@description('ID do IP Publico')
param publicip_id string
@description('Nome da vNet')
param vnet_name string

var network_name = 'cg-${environment}-vgw-${iniciativa}-${regiao}-${identificador}'
var subnet_id = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_name,'GatewaySubnet') 


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
