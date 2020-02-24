
resource "azurerm_resource_group" "global" {
  name     = var.rg_name
  location = var.location
}
