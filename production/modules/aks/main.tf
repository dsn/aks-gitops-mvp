
data "azurerm_resource_group" "cluster" {
  name = var.resource_group_name
}

data "azurerm_subscription" "current" {
}

# resource "random_id" "workspace" {
#   keepers = {
#     group_name = data.azurerm_resource_group.cluster.name
#   }

#   byte_length = 8
# }
#
# resource "azurerm_log_analytics_workspace" "workspace" {
#   name                = "k8s-workspace-${random_id.workspace.hex}"
#   location            = data.azurerm_resource_group.cluster.location
#   resource_group_name = data.azurerm_resource_group.cluster.name
#   sku                 = "PerGB2018"
# }

# resource "azurerm_log_analytics_solution" "solution" {
#   solution_name         = "ContainerInsights"
#   location              = data.azurerm_resource_group.cluster.location
#   resource_group_name   = data.azurerm_resource_group.cluster.name
#   workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
#   workspace_name        = azurerm_log_analytics_workspace.workspace.name

#   plan {
#     publisher = "Microsoft"
#     product   = "OMSGallery/ContainerInsights"
#   }
# }


resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = data.azurerm_resource_group.cluster.location
  resource_group_name = data.azurerm_resource_group.cluster.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = var.admin_user

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  default_node_pool {
    name                  = "default"
    node_count            = var.agent_vm_count
    vm_size               = var.agent_vm_size
    os_disk_size_gb       = var.agent_vm_disk_size
    vnet_subnet_id        = var.subnet_id
    enable_node_public_ip = var.enable_node_public_ip
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_ip
    docker_bridge_cidr = var.docker_cidr
  }

  role_based_access_control {
    enabled = var.role_based_access_control_enabled

    azure_active_directory {
      client_app_id     = var.active_directory_client_app_id
      server_app_id     = var.active_directory_server_app_id
      server_app_secret = var.active_directory_server_app_secret
    }
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }

  addon_profile {
    oms_agent {
      enabled = var.oms_agent_enabled
      # log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
    }

    azure_policy {
      enabled = var.azure_policy_enabled
    }
  }

  tags = var.tags
}


resource "azurerm_policy_assignment" "policy" {
  count        = var.azure_policy_enabled ? 1 : 0
  display_name = "Ensure only allowed container images in Kubernetes cluster"
  name         = "${var.cluster_name}containerImagesPolicy"
  not_scopes   = []
  parameters = jsonencode(
    {
      allowedContainerImagesRegex = {
        value = var.allowedContainerImagesRegex
      }
    }
  )
  # This is id of policy definition for allowed images in k8s cluster.
  # List of possible policies can be found at https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Definitions
  # Filter the list with "kubernetes" to get aks specific policies
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/febd0533-8e55-448f-b837-bd0e06f16469"
  scope                = data.azurerm_subscription.current.id
}
