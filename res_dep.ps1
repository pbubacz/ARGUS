$subscriptionID = "$SUBSCRIPTION_ID"
$resourceGroupName = "$RG_NAME"
$location = "polandcentral"

az account set --subscription $subscriptionID
az group create --name $resourceGroupName --location $location
az deployment group create --resource-group $resourceGroupName --template-file .\infra\main.bicep
