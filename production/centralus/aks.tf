module "aks" {
  source                   = "../modules/aks"
  resource_group_name      = azurerm_resource_group.primary.name
  agent_vm_count           = var.agent_vm_count
  agent_vm_size            = var.agent_vm_size
  agent_vm_disk_size       = var.agent_vm_disk_size
  service_principal_id     = var.service_principal_id
  service_principal_secret = var.service_principal_secret
  cluster_name             = var.cluster_name
  admin_user               = var.admin_user
  ssh_public_key           = var.ssh_public_key
  tags                     = var.cluster_tags
  subnet_id                = module.vnet.subnet_id
}
