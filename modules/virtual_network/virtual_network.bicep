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
@description('Endereços de Rede utilizados na Vnet')
param addess_space array 
param enableDdosProtection bool = true
param enableVmProtection bool = true

var vnet_name = 'cg-${environment}-vnet-${iniciativa}-${regiao}-${identificador}'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addess_space
    }
    enableDdosProtection: enableDdosProtection
    enableVmProtection: enableVmProtection
  }
}

output vnet_name string = vnet.name
