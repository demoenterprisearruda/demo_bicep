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


param rule_name string
param rule_priority int

@allowed([
  '*'
  'Tcp'
  'Udp'
  'Icmp'
])
param rule_protocol string

@allowed([
  'Allow'
  'Deny'
])
param rule_access string

@allowed([
  'Inbound'
  'Outbound'
])
param rule_direction string
param rule_source_prefix string
param rule_source_port_range string 
param rule_destination_address_prefix string
param rule_destination_port_range string 

param location string = resourceGroup().location

var nsg_name = 'cg-${environment}-nsg-${iniciativa}-${regiao}-${identificador}'

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-08-01' = {
  name: nsg_name
  location: location
  properties: {
    securityRules: [
      {
        name: rule_name
        properties: {
          priority: rule_priority
          protocol: rule_protocol
          access: rule_access
          direction: rule_direction
          sourceAddressPrefix: rule_source_prefix
          sourcePortRange: rule_source_port_range
          destinationAddressPrefix: rule_destination_address_prefix
          destinationPortRange: rule_destination_port_range
        }
      }
    ]
  }
}

output nsg_id string = nsg.id
