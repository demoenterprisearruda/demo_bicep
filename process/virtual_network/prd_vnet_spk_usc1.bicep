
//parametros vnet
param regiao string = 'usc1'
param identificador string = '001'
param iniciativa string = 'spk'
param environment string = 'prd'
param adress_space array = [
  '10.133.64.0/18'
]


module virtual_network '../../modules/virtual_network/virtual_network.bicep' = {
  name: 'vnet'
  params: {
    regiao: regiao
    addess_space: adress_space
    environment: environment
    identificador: identificador
    iniciativa: iniciativa
    enableDdosProtection: false
    enableVmProtection: true
  }
}

module subnet1 '../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet1'
  dependsOn: [
    virtual_network
  ]
  params:{
    vnet_name: virtual_network.outputs.vnet_name
    subnet_name: 'snet-default'
    addess_prefix: '10.133.64.0/24'
  }
}
