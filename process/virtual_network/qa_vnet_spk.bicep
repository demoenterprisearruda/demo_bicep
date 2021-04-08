
//parametros vnet
param regiao string = 'use2'
param identificador string = '001'
param iniciativa string = 'spk'
param environment string = 'qa'
param adress_space array = [
  '10.132.64.0/18'
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
    subnet_name: 'snet-app-general'
    addess_prefix: '10.132.64.0/22'
  }
}

module subnet2 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet2'
  dependsOn: [
    subnet1
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-kubernetes'
    addess_prefix: '10.132.88.0/21'
  }
}

module subnet3 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet3'
  dependsOn: [
    subnet2
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-db-general'
    addess_prefix: '10.132.76.0/23'
  }
}

module subnet4 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet4'
  dependsOn: [
    subnet3
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-nie-app'
    addess_prefix: '10.132.68.0/23'
  }
}

module subnet5 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet5'
  dependsOn: [
    subnet4
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-nie-db'
    addess_prefix: '10.132.70.0/24'
  }
}

module subnet6 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet6'
  dependsOn: [
    subnet5
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-gesc-app'
    addess_prefix: '10.132.71.0/25'
  }
}

module subnet7 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet7'
  dependsOn: [
    subnet6
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-gesc-db'
    addess_prefix: '10.132.71.128/25'
  }
}

module subnet8 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet8'
  dependsOn: [
    subnet7
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-relacionamento-app'
    addess_prefix: '10.132.72.0/23'
  }
}

module subnet9 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet9'
  dependsOn: [
    subnet8
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-relacionamento-db'
    addess_prefix: '10.132.74.0/24'
  }
}

module subnet10 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet10'
  dependsOn: [
    subnet9
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-db-mgi'
    addess_prefix: '10.132.78.0/23'
  }
}
