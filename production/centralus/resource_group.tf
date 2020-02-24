resource "azurerm_resource_group" "primary" {
  name     = var.resource_group_name
  location = var.location
}
