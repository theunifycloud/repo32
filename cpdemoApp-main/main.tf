
provider "azurerm"{
version = "~>3.49.0"
subscription_id = ""
client_id  = ""
client_secret  = ""
tenant_id =  ""
features {}
}
resource "azurerm_resource_group" "uc-Shared_RG"{
name = "rg-uc-Shared-001" 
location = "East US 2"
}
resource "azurerm_resource_group" "uc-Network_RG"{
name = "rg-uc-Network-001" 
location = "East US 2"
}
resource "azurerm_resource_group" "uc-Migrate_RG"{
name = "rg-uc-Migrate-001" 
location = "East US 2"
}

resource "azurerm_virtual_network" "uc_Vnet"{
name = "Vnet-uc-VNet-EastUS2-001"
address_space = ["10.0.0.0/16"]
location = azurerm_resource_group.uc-Network_RG.location
resource_group_name = azurerm_resource_group.uc-Network_RG.name 
}

resource "azurerm_subnet" "AzureUATServer_Subnet"{
name = "AzureUATServer"
address_prefixes = ["10.0.0.0/24"]
virtual_network_name = azurerm_virtual_network.uc_Vnet.name 
resource_group_name= azurerm_resource_group.uc-Network_RG.name 
}
resource "azurerm_storage_account" "ucstracc-stracc"{
name= "stucstracc" 
location= azurerm_resource_group.uc-Shared_RG.location
resource_group_name= azurerm_resource_group.uc-Shared_RG.name
account_tier = "Standard" 
account_replication_type  =  "LRS" 
}
resource "azurerm_log_analytics_workspace" "uc-loganaly-loganaly"{
name= "log-uc-loganaly-loganaly-001" 
location= azurerm_resource_group.uc-Shared_RG.location
resource_group_name= azurerm_resource_group.uc-Shared_RG.name
sku = "PerGB2018" 
retention_in_days= 30
}

resource "azurerm_key_vault" "uc-KeyVault-Keyvault"{
name = "kvuckeyvaulteastus"
location = azurerm_resource_group.uc-Shared_RG.location
resource_group_name = azurerm_resource_group.uc-Shared_RG.name
tenant_id = ""
enabled_for_disk_encryption  = true
soft_delete_retention_days    = 7
purge_protection_enabled   = false
sku_name = "standard"
}