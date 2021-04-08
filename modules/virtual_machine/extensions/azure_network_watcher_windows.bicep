param vm_name string
param location string = resourceGroup().location

resource az_watcher 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: '${vm_name}/AzureNetworkWatcherExtension'
  location: location
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Azure.NetworkWatcher'
    type: 'NetworkWatcherAgentWindows'
    typeHandlerVersion: '1.4'
  }
}
