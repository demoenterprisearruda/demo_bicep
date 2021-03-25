param storage_name string
param container_name string

resource fileservice 'Microsoft.Storage/storageAccounts/fileServices@2020-08-01-preview' = {
  name: '${storage_name}/default/${container_name}'
}