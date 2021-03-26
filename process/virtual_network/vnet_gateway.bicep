
param environment string
param identificador string
param iniciativa string
param regiao string
param vnet_name string
param gateway_type string 
param vpn_sku string
param vpn_type string

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
    privateip_allocation_method: ip.outputs.publicip_allocation_method
    publicip_id: ip.outputs.publicip_id
    regiao: regiao
    vpn_sku: vpn_sku
    vpn_type: vpn_type
    vnet_name: vnet_name
  }
}
