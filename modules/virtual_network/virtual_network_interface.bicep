
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

@description('Resource Group da Vnet')
param vnetRG string
@description('Nome da Vnet')
param vnetName string
@description('Nome da Subnet')
param subnetName string

var nic_name = 'cg-${environment}-nic-${iniciativa}-${regiao}'

resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic_name
  location: location
  properties: {
    ipConfigurations:[
      {
        name: 'internal'
        properties:{
          privateIPAllocationMethod: 'Dynamic'
          subnet:{
            id: '${resourceId(vnetRG, 'Microsoft.Network/virtualNetworks', vnetName)}/subnets/${subnetName}'
          }
        }
      }
    ]
  }
}
