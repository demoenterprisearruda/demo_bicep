
//parametros vnet
param regiao string = 'brs1'
param identificador string = '001'
param iniciativa string = 'hub'
param adress_space array = [
  '10.132.0.0/18'
]


module virtual_network '../../../modules/virtual_network/virtual_network.bicep' = {
  name: 'vnet'
  params: {
    regiao: regiao
    addess_space: adress_space
    environment: 'dev'
    identificador: identificador
    iniciativa: iniciativa
  }
}

module virtual_network_subnet '../../../modules/virtual_network/subnet.bicep' = {
  name: 'subnet'
  params:{
    vnet_name: virtual_network.name
    subnet_name: 'teste'
    addess_prefix: '10.132.0.0/22'
  }
}
