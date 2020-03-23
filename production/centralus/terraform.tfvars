resource_group_name               = "gitops-rg-aks-mvp"
cluster_name                      = "centralus-production-aks"
prefix                            = "centralusproduction"
oms_agent_enabled                 = "false"
azure_policy_enabled              = "true"
role_based_access_control_enabled = "true"
agent_vm_count                    = 3

vnet_tags = {
  "billingcode" = "0"
  customer      = "boxboat"
  department    = "engineering"
  environment   = "development"
  owner         = "boxboat"
  project       = "internal"
}
cluster_tags = {
  "billingcode" = "0"
  customer      = "boxboat"
  department    = "engineering"
  environment   = "development"
  owner         = "boxboat"
  project       = "internal"
}
# to force trigger a build
random = "11"
