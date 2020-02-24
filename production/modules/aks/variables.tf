
variable "resource_group_name" {
  type        = string
  description = "resource group name"
  default     = ""
}

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

variable "tags" {
  type        = map
  description = "tags for your aks cluster"
  default = {
  }
}

variable "service_principal_id" {
  type        = string
  description = "value of ARM_CLIENT_ID env var or service principal id"
}

variable "service_principal_secret" {
  type        = string
  description = "value of ARM_CLIENT_SECRET env var. If you commit .tfvars file then don't put this in there. Use TF_VAR_service_principal_secret env var in protected container to store this value"
}


variable "enable_node_public_ip" {
  description = "Attaches a public ip to nodes running in aks cluster"
  default     = false
}


variable "cluster_name" {
  type    = string
  default = "production-aks"
}

variable "dns_prefix" {
  type    = string
  default = "prod"
}

variable "admin_user" {
  type    = string
  default = "k8sadmin"
}

variable "ssh_public_key" {
  type = string
}

variable "output_directory" {
  type    = string
  default = "./output"
}

variable "kubeconfig_to_disk" {
  description = "This disables or enables the kube config file from being written to disk."
  type        = string
  default     = "true"
}

variable "kubeconfig_filename" {
  description = "Name of the kube config file saved to disk."
  type        = string
  default     = "kube_config"
}

variable "service_cidr" {
  default     = "10.0.0.0/16"
  description = "Used to assign internal services in the AKS cluster an IP address. This IP address range should be an address space that isn't in use elsewhere in your network environment. This includes any on-premises network ranges if you connect, or plan to connect, your Azure virtual networks using Express Route or a Site-to-Site VPN connections."
  type        = string
}

variable "dns_ip" {
  default     = "10.0.0.10"
  description = "should be the .10 address of your service IP address range"
  type        = string
}

variable "docker_cidr" {
  default     = "172.17.0.1/16"
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Default of 172.17.0.1/16."
}

variable "network_plugin" {
  default     = "azure"
  description = "Network plugin used by AKS. Either azure or kubenet."
}
variable "network_policy" {
  default     = "azure"
  description = "Network policy to be used with Azure CNI. Either azure or calico."
}

variable "oms_agent_enabled" {
  default     = "false"
  description = "Enable Azure Monitoring for AKS"
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "subnet id for subnet in which pods will reside"
}
