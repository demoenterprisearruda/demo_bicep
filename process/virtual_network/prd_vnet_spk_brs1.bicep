
//parametros vnet
param regiao string = 'brs1'
param identificador string = '001'
param iniciativa string = 'spk'
param environment string = 'prd'
param adress_space array = [
  '10.131.0.0/18'
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
    addess_prefix: '10.131.0.0/22'
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
    addess_prefix: '10.131.8.0/21'
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
    addess_prefix: '10.131.4.0/23'
  }
}

module subnet4 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet4'
  dependsOn: [
    subnet3
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-db-mgi'
    addess_prefix: '10.131.6.0/23'
  }
}

module subnet5 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet5'
  dependsOn: [
    subnet4
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-scada-app'
    addess_prefix: '10.131.16.0/27'
  }
}

module subnet6 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet6'
  dependsOn: [
    subnet5
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-scada-db'
    addess_prefix: '10.131.16.32/28'
  }
}

module subnet7 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet7'
  dependsOn: [
    subnet6
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-telemetria-app'
    addess_prefix: '10.131.16.64/26'
  }
}

module subnet8 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet8'
  dependsOn: [
    subnet7
  ]  
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-telemetria-db'
    addess_prefix: '10.131.16.128/26'
  }
}
