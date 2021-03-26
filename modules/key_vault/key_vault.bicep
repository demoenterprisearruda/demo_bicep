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
param tennantID string = subscription().tenantId

var akv_name = 'cg-${environment}-akv-${iniciativa}-${regiao}-${identificador}'

resource akv 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: akv_name
  location: 'brazilsouth'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tennantID
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: false
    vaultUri: 'https://${akv_name}.vault.azure.net/'
  }
}
