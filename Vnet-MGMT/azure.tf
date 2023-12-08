# Configure the Azure Provider
provider "azurerm" {
  version = "=1.31.0"

  #Management Subscription ID
  subscription_id = "6b9513e0-da9f-4f6f-9da1-2e425f5fffd5"

  #Authenticate to AzureRM
  client_id     = "57e02244-d382-4a9f-b9f3-c836746fc059"
  client_secret = "6eafdb2c-64a9-4297-bfbc-a1121519143b"
  tenant_id     = "c945e155-be68-4477-b8d7-01939adbfe55"
}
