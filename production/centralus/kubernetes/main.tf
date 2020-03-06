# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.44.0"
}

terraform {
  backend "azurerm" {}
}

data "azurerm_kubernetes_cluster" "main" {
  resource_group_name = var.resource_group_name
  name                = var.cluster_name
}

# When using without Active Directory and RBAC, uncomment following
# provider "kubernetes" {
#   version                = "=1.10"
#   host                   = "${data.azurerm_kubernetes_cluster.main.kube_config.0.host}"
#   username               = "${data.azurerm_kubernetes_cluster.main.kube_config.0.username}"
#   password               = "${data.azurerm_kubernetes_cluster.main.kube_config.0.password}"
#   client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_certificate)}"
#   client_key             = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.client_key)}"
#   cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate)}"
# }


provider "kubernetes" {
  version                = "=1.10"
  host                   = data.azurerm_kubernetes_cluster.main.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate)
  load_config_file       = "false"
}

provider "helm" {
  version = "=1.0.0"
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.main.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate)
    load_config_file       = "false"
  }
}
