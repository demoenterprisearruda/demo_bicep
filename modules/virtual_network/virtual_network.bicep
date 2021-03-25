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
param addess_space array 
param enableDdosProtection bool = true
param enableVmProtection bool = true

var vnet_name = 'cg-${environment}-vnet-${iniciativa}-${regiao}-${identificador}'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addess_space
    }
    enableDdosProtection: enableDdosProtection
    enableVmProtection: enableVmProtection
  }
}
