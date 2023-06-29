resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    #name = local.ingress_name
    name = "dev-marques-ops-system-ingress"
    annotations = {
      "alb.ingress.kubernetes.io/load-balancer-name"            = local.load_balancer_name
      "alb.ingress.kubernetes.io/scheme"                        = var.ingress_annotations.scheme
      "alb.ingress.kubernetes.io/healthcheck-protocol"          = var.ingress_annotations.healthcheck-protocol
      "alb.ingress.kubernetes.io/healthcheck-path"              = var.ingress_annotations.healthcheck-path
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds"  = var.ingress_annotations.healthcheck-interval-seconds
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"   = var.ingress_annotations.healthcheck-timeout-seconds
      "alb.ingress.kubernetes.io/healthy-threshold-count"       = var.ingress_annotations.healthy-threshold-count
      "alb.ingress.kubernetes.io/unhealthy-threshold-count"     = var.ingress_annotations.unhealthy-threshold-count
      "alb.ingress.kubernetes.io/success-codes"                 = var.ingress_annotations.success-codes
    }
  }
  spec {
    ingress_class_name = "alb"
    default_backend {
      service {
        name = local.service_name
        port {
          number = 8082
        }
      }
    }
  }
}