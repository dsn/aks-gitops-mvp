
data "helm_repository" "fluxcd" {
  name = "fluxcd"
  url  = "https://charts.fluxcd.io"
}

resource "kubernetes_namespace" "fluxcd" {
  metadata {
    name = "fluxcd"
  }
}

resource "helm_release" "fluxcd" {
  name       = "flux"
  repository = data.helm_repository.fluxcd.metadata[0].name
  chart      = "flux"
  version    = "1.2.0"
  set {
    name  = "git.url"
    value = var.flux_git_url
  }
  set {
    name  = "git.path"
    value = var.flux_git_path
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
  version    = "0.7.0"
  set {
    name  = "git.ssh.secretName"
    value = "flux-git-deploy"
  }
  set {
    name  = "helm.versions"
    value = "3"
  }

  namespace = kubernetes_namespace.fluxcd.metadata[0].name
}
