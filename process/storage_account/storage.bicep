param regiao string
param accessTier string
param environment string
param identificador string
param iniciativa string
param kind string
param sku string
param tier string

module stg '../../modules/storage_account/storage_account.bicep' = {
  name: 'storage-account'
  params: {
    regiao: regiao
    accessTier: accessTier
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    kind: kind
    sku: sku
    tier: tier
  }
}

module ctn '../../modules/storage_account/storage_container.bicep' = {
  name: 'container'
  params:{
    container_name: 'dev'
    storage_name: stg.outputs.storage_name
  }
}
