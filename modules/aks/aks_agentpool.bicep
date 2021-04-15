param aks_cluster_name string
param environment string
param regiao string
param vnet_name string
param min_pool_count int = 5
param max_pool_count int = 30
param kubernetes_version string = '1.16.13'

var vnet_id = '/subscriptions/${subscription().id}/resourceGroups/cg-${environment}-rg-network-${regiao}/providers/Microsoft.Network/virtualNetworks/${vnet_name}'

resource aks_agentpool 'Microsoft.ContainerService/managedClusters/agentPools@2021-02-01' = {
  name: '${aks_cluster_name}/agentpool'
  properties: {
    count: 3
    vmSize: 'Standard_D2_v2'
    osDiskSizeGB: 128
    osDiskType: 'Managed'
    vnetSubnetID: '${vnet_id}/subnets/snet-kubernetes'
    maxPods: 30
    type: 'VirtualMachineScaleSets'
    maxCount: min_pool_count
    minCount: max_pool_count
    enableAutoScaling: true
    orchestratorVersion: kubernetes_version
    mode: 'User'
    osType: 'Linux'
  }
}
