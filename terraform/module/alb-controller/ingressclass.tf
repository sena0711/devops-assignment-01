resource "kubernetes_manifest" "alb_ingressclassparams" {
  manifest = {
    apiVersion = "eks.amazonaws.com/v1"
    kind       = "IngressClassParams"
    metadata = {
      name = "alb"
    }
    spec = {
      scheme = "internet-facing"
    }
  }
}

resource "kubernetes_manifest" "alb_ingressclass" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "IngressClass"
    metadata = {
      name        = "public-alb"
      annotations = {
        "ingressclass.kubernetes.io/is-default-class" = "true"
      }
    }
    spec = {
      controller = "eks.amazonaws.com/alb"
      parameters = {
        apiGroup = "eks.amazonaws.com"
        kind     = "IngressClassParams"
        name     = kubernetes_manifest.alb_ingressclassparams.manifest["metadata"]["name"]
      }
    }
  }

  depends_on = [kubernetes_manifest.alb_ingressclassparams]
}
