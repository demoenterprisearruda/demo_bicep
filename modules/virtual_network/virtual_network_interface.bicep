
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


param vnetRG string
param vnetName string
param subnetName string

var nic_name = 'cg-${environment}-nic-${iniciativa}-${regiao}'

resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: nic_name
  location: location
  properties: {
    ipConfigurations:[
      {
        name: 'internal'
        properties:{
          privateIPAllocationMethod: 'Dynamic'
          subnet:{
            id: '${resourceId(vnetRG, 'Microsoft.Network/virtualNetworks', vnetName)}/subnets/${subnetName}'
          }
        }
      }
    ]
  }
}