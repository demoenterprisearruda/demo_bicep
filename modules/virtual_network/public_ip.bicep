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
param public_ip_alocation_method string = 'Dynamic'

var publicip_name  = 'cg-${environment}-pip-${identificador}'

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicip_name
  location: location
  properties:{
    publicIPAllocationMethod: public_ip_alocation_method
    publicIPAddressVersion: 'IPv4'    

  }
  sku:{
    name: 'Standard'
  }
}

output publicip_id string = publicIp.id
output publicip_allocation_method string = publicIp.properties.publicIPAllocationMethod
