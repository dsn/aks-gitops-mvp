output host {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}

output username {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.username
}

output password {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.password
  sensitive = true
}

output client_certificate {
  value     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  sensitive = true
}

output client_key {
  value     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  sensitive = true
}

output cluster_ca_certificate {
  value     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  sensitive = true
}
output kube_config_raw {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

output kube_admin_config_raw {
  value     = azurerm_kubernetes_cluster.cluster.kube_admin_config_raw
  sensitive = true
}

output kube_config_file {
  value      = "${var.output_directory}/${var.kubeconfig_filename}"
  depends_on = [local_file.cluster_credentials]
}
