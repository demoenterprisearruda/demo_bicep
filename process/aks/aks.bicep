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
param vnet_name string 

param spn_client_id string
@secure()
param spn_client_secret string

module ip '../../modules/virtual_network/public_ip_prefix.bicep' = {
  name: 'publicip'
  params:{
    environment: environment
    identificador: identificador
  }
}

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
    public_ip_id: ip.outputs.public_ip_prefix_id
  }
  dependsOn:[
    ip
  ]
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
