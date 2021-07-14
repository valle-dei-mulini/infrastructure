data "aws_eks_cluster" "this" {
  name = var.cluster_name
}

# Create namespace logging
resource "kubernetes_namespace" "this" {
  depends_on = [
    var.module_depends_on
  ]
  count = var.namespace == "" ? 1 - local.argocd_enabled : 0
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "this" {
  count = 1 - local.argocd_enabled

  depends_on = [
    var.module_depends_on
  ]

  name          = local.name
  repository    = local.repository
  chart         = local.chart
  version       = local.version
  namespace     = local.namespace
  recreate_pods = true
  timeout       = 1200

  dynamic "set" {
    for_each = merge(local.conf)

    content {
      name  = set.key
      value = set.value
    }
  }
}

resource "local_file" "this" {
  count = local.argocd_enabled
  depends_on = [
    var.module_depends_on
  ]
  content  = yamlencode(local.application)
  filename = "${path.root}/${var.argocd.path}/${local.name}.yaml"
}

locals {
  argocd_enabled = length(var.argocd) > 0 ? 1 : 0
  namespace      = coalescelist(var.namespace == "" && local.argocd_enabled > 0 ? [{ "metadata" = [{ "name" = var.namespace_name }] }] : kubernetes_namespace.this, [{ "metadata" = [{ "name" = var.namespace }] }])[0].metadata[0].name

  name       = "app"
  repository = "../charts"
  chart      = "app"
  version    = var.chart_version
  conf       = merge(local.conf_defaults, var.conf)

  conf_defaults = {
    "backend.image.tag"     = "ci-31eb576ea48ebfcd5997f5ca464607da667c26cc"
    "backend.serviceName"   = "backend-service"
    "backend.frontendURL"   = "http://frontend-service:3000"
    "backend.service.port"  = 5000
    "frontend.image.tag"    = "ci-796154666a25eb50ebdf01e305562ffd74e1f994"
    "frontend.serviceName"  = "frontend-service"
    "frontend.backendURL"   = "http://backend-service:5000"
    "frontend.service.port" = 3000
  }

  application = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = local.name
      "namespace" = var.argocd.namespace
    }
    "spec" = {
      "destination" = {
        "namespace" = local.namespace
        "server"    = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "repoURL"        = local.repository
        "targetRevision" = local.version
        "chart"          = local.chart
        "helm" = {
          "parameters" = values({
            for key, value in local.conf :
            key => {
              "name"  = key
              "value" = tostring(value)
            }
          })
        }
      }
      "syncPolicy" = {
        "syncOptions" = [
          "CreateNamespace=true"
        ]
        "automated" = {
          "prune"    = true
          "selfHeal" = true
        }
      }
    }
  }
}