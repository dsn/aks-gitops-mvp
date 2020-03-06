output "client_certificate" {
  sensitive = true
  value     = module.aks.client_certificate
}
