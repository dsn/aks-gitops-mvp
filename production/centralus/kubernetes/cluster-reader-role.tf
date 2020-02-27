resource "kubernetes_cluster_role" "cluster_reader" {
  metadata {
    annotations = {}
    labels      = {}
    name        = "cluster-reader"
  }

  rule {
    api_groups = [
      "",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "configmaps",
      "endpoints",
      "persistentvolumeclaims",
      "pods",
      "replicationcontrollers",
      "replicationcontrollers/scale",
      "serviceaccounts",
      "services",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "bindings",
      "events",
      "limitranges",
      "namespaces/status",
      "pods/log",
      "pods/status",
      "replicationcontrollers/status",
      "resourcequotas",
      "resourcequotas/status",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "namespaces",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "apps",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "controllerrevisions",
      "daemonsets",
      "deployments",
      "deployments/scale",
      "replicasets",
      "replicasets/scale",
      "statefulsets",
      "statefulsets/scale",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "autoscaling",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "horizontalpodautoscalers",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "batch",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "cronjobs",
      "jobs",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "extensions",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "daemonsets",
      "deployments",
      "deployments/scale",
      "ingresses",
      "networkpolicies",
      "replicasets",
      "replicasets/scale",
      "replicationcontrollers/scale",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "policy",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "poddisruptionbudgets",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rule {
    api_groups = [
      "networking.k8s.io",
    ]
    non_resource_urls = []
    resource_names    = []
    resources = [
      "ingresses",
      "networkpolicies",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
}
