resource "local_file" "cluster_credentials" {
  count                = var.kubeconfig_to_disk ? 1 : 0
  sensitive_content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
  filename             = "${var.output_directory}/${var.kubeconfig_filename}"
  file_permission      = "0600"
  directory_permission = "0700"

  depends_on = [azurerm_kubernetes_cluster.cluster]
}
