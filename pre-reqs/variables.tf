variable "prefix" {
  type        = string
  description = "prefix for all resources created with this configuration"
  default     = "aks-gitops"
}

variable "rg_name" {
  type        = string
  description = "name of resource group which will store backend configuration"
  default     = "aks-gitops-global"
}

variable "location" {
  type        = string
  description = "location"
  default     = "centralus"
}

variable "principal_password_enddate" {
  type        = string
  description = "date of expiry for service principal password"
  default     = "2025-01-01T01:02:03Z"
}

variable "backend_storage_account_name" {
  type        = string
  description = "name of storage account. Must be lowercase aphanumeric unique value"
  default     = "bbaksgitopsaksstorage"
}

variable "backend_storage_container_name" {
  type        = string
  description = "name of container. Must be lowercase aphanumeric value"
  default     = "tfbackendcontainer"
}
