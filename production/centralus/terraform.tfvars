resource_group_name = "gitops-rg-aks-mvp"
cluster_name        = "centralus-production-aks"
prefix              = "centralusproduction"
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
random = "5"
