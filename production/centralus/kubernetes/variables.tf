variable "resource_group_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

# @todo remove this
variable "random" {
  type        = string
  description = "change this in .tfvars to force trigger a new build on master"
}
