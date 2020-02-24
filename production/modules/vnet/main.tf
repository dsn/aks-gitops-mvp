data "azurerm_resource_group" "vnet" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.vnet.location
  address_space       = [var.address_space]
  resource_group_name = data.azurerm_resource_group.vnet.name
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet.name

  address_prefix    = var.subnet_prefix
  service_endpoints = var.subnet_service_endpoints
}
