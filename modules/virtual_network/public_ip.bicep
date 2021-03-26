@allowed([
  'dev'
  'qa'
  'prd'
  'sdx'
])
@description('Sigla do Ambiente onde o recurso está rodando')
param environment string
@description('ID numérico de 3 digitos que compôe o nome do recurso')
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
output publicip_allocation_method string = publicIp.properties.publicIPAllocationMethod
