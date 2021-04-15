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
param identificador string = '999'
param vnet_name string = 'cg-prd-vnet-hub-brs1-001'

param spn_client_id string = '2fc798b5-66bb-4ec5-927f-b12d053d4cd4'
@secure()
param spn_client_secret string = 'Aqon_QA.hPTTw9owYqf_GKo8SMoRoX~Z6A'

module aks '../../modules/aks/aks_cluster.bicep' = {
  name: 'aks'
  params:{
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    regiao: regiao
    spn_client_id: spn_client_id
    spn_client_secret: spn_client_secret
    vnet_name: vnet_name
  }
}

module aks_pool '../../modules/aks/aks_agentpool.bicep' = {
  name: 'pool'
  params:{
    aks_cluster_name: aks.outputs.aks_name
    environment: environment
    regiao: regiao
    vnet_name: vnet_name
  }
  dependsOn:[
    aks
  ]
}
