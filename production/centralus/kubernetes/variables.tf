variable "resource_group_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "flux_git_url" {
  type        = string
  description = "git url in format git@github.com:<owner name>/<repo name>"
}
variable "flux_git_path" {
  type        = string
  description = "path in git repo which flux will monitor for changes"
}

variable "flux_syncGarbageCollection_enabled" {
  type        = string
  description = "When you delete a resource from git repository, it will also be deleted from cluster if this is set to true"
  default     = "false"
}

variable "flux_chart_version" {
  type    = string
  default = "1.2.0"
}

variable "flux_helm_operator_chart_version" {
  type    = string
  default = "0.7.0"
}

# @todo remove this
variable "random" {
  type        = string
  description = "change this in .tfvars to force trigger a new build on master"
}
