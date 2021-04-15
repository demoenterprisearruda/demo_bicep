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

@description('Nome da vNet')
param vnet_name string

module ip '../../modules/virtual_network/public_ip.bicep' = {
  name: 'public-ip'
  params: {
    environment: environment
    identificador: identificador
  }
}

module vgw '../../modules/virtual_network/virtual_network_gateway.bicep' = {
  name: 'virtual-network-gateway'
  params: {
    environment: environment
    gateway_type: gateway_type
    identificador: identificador
    iniciativa: iniciativa
    privateip_allocation_method: privateip_allocation_method
    publicip_id: ip.outputs.publicip_id
    regiao: regiao
    vpn_sku: vpn_sku
    vpn_type: vpn_type
    vnet_name: vnet_name
  }
}
