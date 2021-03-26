@description('Nome do Keyvault')
param akv_name string
@description('Nome da Chave salva no Keyvault')
param akv_secret_name string
@description('Valor do Segredo para salvar no Keyvault')
param akv_secret_value string

resource secrets 'Microsoft.KeyVault/vaults/secrets@2018-02-14' =  {
  name: '${akv_name}/teste'
  properties: {
    value: 'secret.secretValue'
  }
}
