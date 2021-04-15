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
@description('ID numérico de 3 digitos que compôe o nome do recurso')
param identificador string

@description('ID da interface de rede')
param network_interface_id string

@allowed([
  '12.04.5-LTS'
  '14.04.5-LTS'
  '16.04.0-LTS'
  '18.04-LTS'
])
param ubuntu_os string = '18.04-LTS'

@allowed([
  'Standard_D8s_v4'
])
@description('Tamanho da VM')
param vm_size string = 'Standard_D8s_v4'

param vm_ssh_key string

param location string = resourceGroup().location
param guid string = newGuid()
var vm_name = 'cg${environment}${iniciativa}${identificador}'
var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/adminuser/.ssh/authorized_keys'
        keyData: vm_ssh_key
      }
    ]
  }
}



resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vm_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: ubuntu_os
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: network_interface_id
        }
      ]
    }
    osProfile: {
      computerName: vm_name
      adminUsername: 'adminuser'
      adminPassword: vm_ssh_key
      linuxConfiguration: linuxConfiguration
    }
  }
}

output vm_name string = vm_name
