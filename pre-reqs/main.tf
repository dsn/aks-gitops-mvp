# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=1.44.0"
}

provider "azuread" {
  version = "=0.7.0"
}

provider "random" {
  version = "=2.2.1"
}
