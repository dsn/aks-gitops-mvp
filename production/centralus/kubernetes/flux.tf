
resource "kubernetes_namespace" "fluxcd" {
  metadata {
    name = "fluxcd"
  }
}

resource "tls_private_key" "flux" {
  algorithm = "RSA"
}

resource "kubernetes_secret" "flux" {
  metadata {
    name      = "flux-git-deploy"
    namespace = kubernetes_namespace.fluxcd.metadata[0].name
  }
  data = {
    identity = tls_private_key.flux.private_key_pem
  }

}


data "helm_repository" "fluxcd" {
  name = "fluxcd"
  url  = "https://charts.fluxcd.io"
}

resource "helm_release" "fluxcd" {
  name       = "flux"
  repository = data.helm_repository.fluxcd.metadata[0].name
  chart      = "flux"
  version    = var.flux_chart_version
  set {
    name  = "git.url"
    value = var.flux_git_url
  }
  set {
    name  = "git.path"
    value = var.flux_git_path
  }

  set {
    name  = "git.secretName"
    value = kubernetes_secret.flux.metadata[0].name
  }

  set {
    name  = "syncGarbageCollection.enabled"
    value = var.flux_syncGarbageCollection_enabled
  }

  namespace = kubernetes_namespace.fluxcd.metadata[0].name
}

resource "helm_release" "helm-operator" {
  name       = "helm-operator"
  repository = data.helm_repository.fluxcd.metadata[0].name
  chart      = "helm-operator"
  version    = var.flux_helm_operator_chart_version
  set {
    name  = "git.ssh.secretName"
    value = kubernetes_secret.flux.metadata[0].name
  }
  set {
    name  = "helm.versions"
    value = "v3"
  }

  namespace = kubernetes_namespace.fluxcd.metadata[0].name
}

output flux_public_key {
  value = tls_private_key.flux.public_key_openssh
}
