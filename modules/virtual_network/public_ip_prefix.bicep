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

resource publicIPPrefixName 'Microsoft.Network/publicIPPrefixes@2018-07-01' = {
  name: publicip_name
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    prefixLength: 28
    publicIPAddressVersion: 'IPv4'
  }
}

output public_ip_prefix_id string = publicIPPrefixName.id
