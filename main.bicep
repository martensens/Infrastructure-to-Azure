targetScope = 'subscription'


@description ('Name des Projekts')
param projectName string = 'infrastructure'

@description ('Name der Umgebung')
param environmentName string = 'dev'

@description ('Location der ResourceGroup')
param location string = 'westeurope'

var resGroupName string = 'rg_${environmentName}_${projectName}' 

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resGroupName
  location: location
}

module containerRegistryModule 'acr.bicep' = {
  name: 'containerRegistryModule'
  scope: resourceGroup
  params: {
    acrName: 'acr${environmentName}${projectName}'
  }
}

output containerRegistryName string = containerRegistryModule.outputs.acrName 
