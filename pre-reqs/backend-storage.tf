resource "azurerm_storage_account" "primary" {
  name                     = var.backend_storage_account_name
  resource_group_name      = azurerm_resource_group.global.name
  location                 = azurerm_resource_group.global.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_blob_encryption   = true
}

resource "azurerm_storage_container" "primary" {
  name                  = var.backend_storage_container_name
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "blob"
}

