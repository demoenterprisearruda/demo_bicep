param akv_name string
param akv_secret_name string
param akv_secret_value string

resource secrets 'Microsoft.KeyVault/vaults/secrets@2018-02-14' =  {
  name: '${akv_name}/teste'
  properties: {
    value: 'secret.secretValue'
  }
}
