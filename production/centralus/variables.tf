variable "location" {
  type        = string
  description = "location"
  default     = "centralus"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
  default     = ""
}

variable "prefix" {
  type        = string
  description = "prefix for all resources created"
  default     = "aksGitOps"
}

## Vnet vars

variable "vnet_tags" {
  description = "The tags to associate with your network and vnet."
  type        = map
  default     = {}
}


############
# Cluster vars
############


variable "agent_vm_count" {
  type        = number
  description = "number of nodes in k8s cluster"
  default     = 2
}

variable "agent_vm_size" {
  type        = string
  description = "size of vm for each node in cluster"
  default     = "Standard_D2_v2"
}

variable "agent_vm_disk_size" {
  type        = number
  description = "disk size of vm for each node in cluster"
  default     = 30
}

variable "aks_service_principal_id" {
  type        = string
  description = "value of ARM_CLIENT_ID env var or service principal id"
}

variable "aks_service_principal_secret" {
  type        = string
  description = "value of ARM_CLIENT_SECRET env var. If you commit .tfvars file then don't put this in there. Use TF_VAR_service_principal_secret env var in protected container to store this value"
}

variable "cluster_name" {
  type = string
}

variable "admin_user" {
  type    = string
  default = "k8sadmin"
}

variable "ssh_public_key" {
  type = string
}

variable "cluster_tags" {
  type        = map
  description = "tags for your aks cluster"
  default = {
  }
}

variable "oms_agent_enabled" {
  default     = "false"
  description = "Enable Azure Monitoring for AKS"
  type        = string
}

variable "azure_policy_enabled" {
  default     = "false"
  description = "Enable Azure Policy for AKS"
  type        = string
}


variable "role_based_access_control_enabled" {
  default     = "true"
  description = "Enable Role Based Accesss Control for AKS"
  type        = string
}

variable "active_directory_client_app_id" {
  type        = string
  description = "client_app_id for active directory integration"
  default     = ""
}

variable "active_directory_server_app_id" {
  type        = string
  description = "server_app_id for active directory integration"
  default     = ""
}

variable "active_directory_server_app_secret" {
  type        = string
  description = "directory_server_app_secret for active directory integration"
}

# @todo remove this
variable "random" {
  type        = string
  description = "change this in .tfvars to force trigger a new build on master"
}
