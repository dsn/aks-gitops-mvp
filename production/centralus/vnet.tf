module "vnet" {
  source              = "../modules/vnet"
  resource_group_name = azurerm_resource_group.primary.name
  tags                = var.vnet_tags
}
