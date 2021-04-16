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

var nsg_name = 'cg-${environment}-nsg-${iniciativa}-${regiao}-${identificador}'

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: nsg_name
  location: location
  properties: {
    securityRules: []
  }
}

output nsg_id string = nsg.id
output nsg_name string = nsg_name
