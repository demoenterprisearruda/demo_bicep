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

@description('ID da interface de rede')
param network_interface_id string

@allowed([
  '12.04.5-LTS'
  '14.04.5-LTS'
  '16.04.0-LTS'
  '18.04-LTS'
])
param ubuntu_os string = '18.04-LTS'

@allowed([
  'Standard_D8s_v4'
])
@description('Tamanho da VM')
param vm_size string = 'Standard_D8s_v4'

param vm_ssh_key string

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

module vm '../../modules/virtual_machine/virtual_machine_linux.bicep' = {
  name: 'vm'
  params:{
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    network_interface_id: nic.outputs.nic_id
    ubuntu_os: ubuntu_os
    vm_size: vm_size
    vm_ssh_key: vm_ssh_key
  }
}
