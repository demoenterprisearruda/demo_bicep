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

@allowed([
  'Standard_D8s_v4'
])
@description('Tamanho da VM')
param vm_size string 

@allowed([
  '2008-R2-SP1'
  '2016-Datacenter'
  '2019-Datacenter'
])
@description('Imagem Windows Utilizada')
param vm_os string 

param vnet_name string 
param vnet_subnet string 
param vnet_rg string 

module nic '../../modules/virtual_network/virtual_network_interface.bicep' = {
  name: 'nic'
  params: {
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    regiao: regiao
    subnetName: vnet_subnet
    vnetName: vnet_name
    vnetRG: vnet_rg
  }
}

module vm '../../modules/virtual_machine/virtual_machine_windows.bicep' = {
  name: 'vm'
  params:{
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    vm_size: vm_size
    windows_os: vm_os
    network_interface_id: nic.outputs.nic_id  
  }
  dependsOn:[
    nic
  ]
}

module vm_extension '../../modules/virtual_machine/extensions/azure_network_watcher_windows.bicep' = {
  name: 'vm_extension'
  params:{
    vm_name: vm.outputs.vm_name
  }
  dependsOn: [
    vm
  ]
}
