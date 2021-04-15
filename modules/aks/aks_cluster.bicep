
param location string = resourceGroup().location
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


var aks_cluster_name = 'cg-${environment}-aks-${iniciativa}-${regiao}-${identificador}'
var vnet_id = '/subscriptions/${subscription().id}/resourceGroups/cg-${environment}-rg-network-${regiao}/providers/Microsoft.Network/virtualNetworks/${vnet_name}'

resource aks_cluster 'Microsoft.ContainerService/managedClusters@2021-02-01' = {
  name: aks_cluster_name
  location: location
  sku: {
    name: 'Basic'
    tier: 'Free'
  }
  properties: {
     agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: 128
        count: 3
        vmSize: 'Standard_D2_v2'
        osType: 'Linux'
      }
    ]
    windowsProfile: {
      adminUsername: 'azureuser'
    }
    servicePrincipalProfile: {
      clientId: spn_client_id
      secret: spn_client_secret
    }
  }
}

output aks_name string = aks_cluster_name
