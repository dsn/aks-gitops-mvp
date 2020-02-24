variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "acctvnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = "10.10.0.0/16"
}

variable "resource_group_name" {
  type        = string
  description = "resource group name"
  default     = ""
}


# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.10.1.0/24"
}

variable "subnet_name" {
  description = "Public subnet inside the vNet."
  type        = string
  default     = "subnet1"
}

variable "subnet_service_endpoints" {
  description = "A list of the service endpoint for the subnet (e.g. Microsoft.Web)"
  type        = list
  default     = []
}

variable "tags" {
  description = "The tags to associate with your network and vnet."
  type        = map
  default     = {}
}
