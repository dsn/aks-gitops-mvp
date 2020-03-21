resource_group_name                = "gitops-rg-aks-mvp"
cluster_name                       = "centralus-production-aks"
flux_git_url                       = "git@github.com:haisumb/aks-gitops-mvp-flux"
flux_git_path                      = "environments/staging/centralus/apps"
flux_syncGarbageCollection_enabled = "true"
# to force trigger a build
random = "12"
