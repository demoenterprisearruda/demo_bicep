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

@description('SKU do Storage Account')
param sku string
@description('Tier do Storage Account')
param tier string
@description('Tipo do Storage Account')
param kind string
@description('Access Tier do Storage Account')
param accessTier string

var storage_name = 'cg${environment}stg${iniciativa}${identificador}'

resource stg 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: storage_name
  location: location
  kind: kind
  sku: {
    name: sku
    tier: tier
  }
  properties: {
    accessTier: accessTier
  }
}
