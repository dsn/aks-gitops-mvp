terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.44.0"
}

provider "local" {
  version = "=1.4"
}

provider "random" {
  version = "=2.2.1"
}

provider "kubernetes" {
  version                = "=1.11"
  host                   = module.aks.host
  username               = module.aks.username
  password               = module.aks.password
  client_certificate     = module.aks.client_certificate
  client_key             = module.aks.client_key
  cluster_ca_certificate = module.aks.cluster_ca_certificate
}


