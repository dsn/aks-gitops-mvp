ssh_public_key       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDT9ZaOjaHcvO6icvPedgy73mxKpzGOU4U7rbXuyINGZNL0RSAjyJvHoB8Sm1xAgjrWKE4N58WOOOjW/EeNoP9m/aWDamDEawuV5B+2gpSIqliK9f3l7ssftB6pfl+/gqSpGu03QZ1BxtI1NTOCf447foXOtkqmmlnM1sswuo/XWvL/IEsTYCSOCju3nlyQPtruoO9bfT6kg4CnUmML9HIw7JsDAZceVV83iVY01KU13uFF1KETvxDvn9YABX1Cyx7yKRVsKJkj7dgndyCAu52qi6erD7wAKKMIoKTJbkCVExjHlXOd6WBq0A3azpel0ZOH+autcQ/e0R6m4MOj+7D haisum@Haisums-MacBook-Pro.local"
service_principal_id = "57412d74-16d7-4cb2-9129-1a7695ed9941"
resource_group_name  = "aks-gitops-rg"
cluster_name         = "aks-production"
prefix               = "production"
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
