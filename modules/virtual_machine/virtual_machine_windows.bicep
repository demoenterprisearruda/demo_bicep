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
param location string = resourceGroup().location

@description('ID da interface de rede')
param network_interface_id string

@allowed([
  '2008-R2-SP1'
  '2016-Datacenter'
  '2019-Datacenter'
])
@description('Imagem Windows Utilizada')
param windows_os string = '2016-Datacenter'

@allowed([
  'Standard_F2'
])
@description('Tamanho da VM')
param vm_size string = 'Standard_F2'

param guid string = newGuid()
var vm_password = 'p${uniqueString(resourceGroup().id, deployment().name, guid)}'

var vm_name = 'cg${environment}${iniciativa}${identificador}'
resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vm_name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: windows_os
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        createOption: 'FromImage'
      }
      dataDisks: []
    }
    osProfile: {
      computerName: vm_name
      adminUsername: 'adminuser'
      adminPassword: vm_password
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
        }
        winRM: {
          listeners: []
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: network_interface_id
          properties: {
            primary: true
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    priority: 'Regular'
  }
}

output password string = vm_password
