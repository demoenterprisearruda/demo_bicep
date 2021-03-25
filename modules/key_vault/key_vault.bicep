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
