
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
param kubernetes_version string = '1.20.2'
param public_ip_id string
param serviceCidr string = '10.10.18.0/24'
param dnsServiceIP string = '10.10.18.10'
param dockerBridgeCidr string = '172.17.0.1/16'

var aks_cluster_name = 'cg-${environment}-aks-${iniciativa}-${regiao}-${identificador}'
var vnet_id = '${subscription().id}/resourceGroups/cg-${environment}-rg-network-${regiao}/providers/Microsoft.Network/virtualNetworks/${vnet_name}'

resource aks_cluster 'Microsoft.ContainerService/managedClusters@2019-08-01' = {
  location: resourceGroup().location
  name: aks_cluster_name
  properties: {
    kubernetesVersion: kubernetes_version
    enableRBAC: true
    dnsPrefix: aks_cluster_name
    agentPoolProfiles: [
      {
        name: 'agentpool'
        osDiskSizeGB: 128
        count: 3
        vmSize: 'Standard_D2_v2'
        osType: 'Linux'
        //storageProfile: 'ManagedDisks'
        type: 'VirtualMachineScaleSets'
        vnetSubnetID: '${vnet_id}/subnets/snet-kubernetes'
      }
    ]
    servicePrincipalProfile: {
      clientId: spn_client_id
      secret: spn_client_secret
    }
    networkProfile: {
      loadBalancerSku: 'standard'
      networkPlugin: 'azure'
      serviceCidr: serviceCidr
      dnsServiceIP: dnsServiceIP
      dockerBridgeCidr: dockerBridgeCidr
      loadBalancerProfile: {
        outboundIPPrefixes: {
          publicIPPrefixes: [
            {
              id: public_ip_id
            }
          ]
        }
      }
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: false
      }
    }
  }
}

output controlPlaneFQDN string = reference('Microsoft.ContainerService/managedClusters/${aks_cluster_name}').fqdn
output aks_name string = aks_cluster_name
