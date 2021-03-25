@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
param environment string
param iniciativa string
param regiao string
param identificador string
param location string = resourceGroup().location

param sku string
param tier string
param kind string
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