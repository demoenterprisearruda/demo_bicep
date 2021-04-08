@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
@description('Sigla do Ambiente onde o recurso está rodando')
param environment string = 'dev'

@allowed([
  'spk'
  'hub'
])
@description('Sigla de 3 digitos que identifica a iniciativa do recurso')
param iniciativa string = 'spk'

@allowed([
  'use2'
  'brs1'
  'usc1'
])
@description('Sigla de 3 digitos que identifica a região do recurso')
param regiao string = 'brs1'

@description('ID numérico de 3 digitos que compôe o nome do recurso')
param identificador string = '001'

@allowed([
  'Standard_F2'
  'Standard_D8s_v4'
])
@description('Tamanho da VM')
param vm_size string = 'Standard_F2'

@allowed([
  '2008-R2-SP1'
  '2016-Datacenter'
  '2019-Datacenter'
])
@description('Imagem Windows Utilizada')
param vm_os string = '2016-Datacenter'

param vnet_name string = 'cg-dev-vnet-hub-brs1-001'
param vnet_subnet string = 'teste'
param vnet_rg string = 'demogft'

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
