param storage_name string
param container_name string

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2020-08-01-preview' = {
  name: '${storage_name}/default/${container_name}'
}