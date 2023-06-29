resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    #name =  var.prefix_name
    name = "dev-marques-ops-news-deployment"
    labels = {
      app = var.prefix_name
    }
  }

  spec{
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.prefix_name
      }
    }
    strategy {
      rolling_update {
        max_surge       = var.rolling_update.max_surge
        max_unavailable = var.rolling_update.max_unavailable
      }
    }
    template {
      metadata {
        labels = {
          app = var.prefix_name
        }
      }
      spec {
        container {
          name = local.container_name
          image = local.image_name
          port {
            name            = "http"
            container_port  = 80
          }
          liveness_probe {
            http_get {
              path = var.ingress_annotations.healthcheck-path
              port = "80"
            }
            initial_delay_seconds = 3
            period_seconds        = 5
            timeout_seconds       = 2
            success_threshold     = 1
            failure_threshold     = 2
          }
        }
        restart_policy = "Always"
      }
    }
  }
}