@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
param environment string
param identificador string
param location string = resourceGroup().location

var publicip_name  = 'cg-${environment}-pip-${identificador}'

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicip_name
  location: location
  properties:{
    publicIPAllocationMethod: 'Dynamic'
  }

}

output publicip_id string = publicIp.id