
//parametros vnet
param regiao string = 'use2'
param identificador string = '001'
param iniciativa string = 'hub'
param environment string = 'prd'
param adress_space array = [
  '10.130.32.0/19'
]


module virtual_network '../../modules/virtual_network/virtual_network.bicep' = {
  name: 'vnet'
  params: {
    regiao: regiao
    addess_space: adress_space
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    enableDdosProtection: false
    enableVmProtection: true
  }
}

module subnet1 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet1'
  dependsOn: [
    virtual_network
  ]
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'GatewaySubnet'
    addess_prefix: '10.130.32.0/26'
  }
}

module subnet2 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet2'
  dependsOn: [
    subnet1
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-fw-internal'
    addess_prefix: '10.130.32.64/26'
  }
}

module subnet3 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet3'
  dependsOn: [
    subnet2
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-fw-external'
    addess_prefix: '10.130.32.128/26'
  }
}

module subnet4 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet4'
  dependsOn: [
    subnet3
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-ad'
    addess_prefix: '10.130.33.0/26'
  }
}

module subnet5 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet5'
  dependsOn: [
    subnet4
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-exchange'
    addess_prefix: '10.130.33.64/26'
  }
}

module subnet6 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet6'
  dependsOn: [
    subnet5
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-sharepoint'
    addess_prefix: '10.130.33.128/26'
  }
}

module subnet7 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet7'
  dependsOn: [
    subnet6
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-bastion'
    addess_prefix: '10.130.33.192/26'
  }
}

module subnet8 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet8'
  dependsOn: [
    subnet7
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-integration'
    addess_prefix: '10.130.34.0/26'
  }
}

module subnet9 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet9'
  dependsOn: [
    subnet8
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-integration-ha'
    addess_prefix: '10.130.34.64/26'
  }
}

module subnet10 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet10'
  dependsOn: [
    subnet9
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-kubernetes'
    addess_prefix: '10.130.36.0/22'
  }
}

//Peering with cg-dev-vnet-spk-use2-001
module peering1 '../../modules/virtual_network/virtual_network_peering.bicep' = {
  name: 'peering_cg-dev-vnet-spk-use2-001'
  params:{
    remoteVnetName: 'cg-dev-vnet-spk-use2-001'
    remoteVnetRg: 'cg-dev-rg-network-use2'
    VnetName: virtual_network.outputs.vnet_name
  }
  dependsOn:[
    subnet10
  ]
}

//Peering with cg-prd-vnet-spk-use2-001
module peering2 '../../modules/virtual_network/virtual_network_peering.bicep' = {
  name: 'peering_cg-prd-vnet-spk-use2-001'
  params:{
    remoteVnetName: 'cg-prd-vnet-spk-use2-001'
    remoteVnetRg: 'cg-prd-rg-network-use2'
    VnetName: virtual_network.outputs.vnet_name
  }
  dependsOn:[
    peering1
  ]
}

//Peering with cg-qa-vnet-spk-use2-001
module peering3 '../../modules/virtual_network/virtual_network_peering.bicep' = {
  name: 'peering_cg-qa-vnet-spk-use2-001'
  params:{
    remoteVnetName: 'cg-qa-vnet-spk-use2-001'
    remoteVnetRg: 'cg-qa-rg-network-use2'
    VnetName: virtual_network.outputs.vnet_name
  }
  dependsOn:[
    peering2
  ]
}
