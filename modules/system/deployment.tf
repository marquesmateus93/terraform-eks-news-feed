resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    #name =  var.prefix_name
    name = "dev-marques-ops-system-deployment"
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
        service_account_name = local.service_account_name
        volume {
          name = local.volume.name
          csi {
            driver    = local.volume.driver
            read_only = true
            volume_attributes = {
              secretProviderClass = local.volume.secret_provider_class
            }
          }
        }
        container {
          name  = local.container_name
          image = local.image_name
          port {
            name            = "http"
            container_port  = 80
          }
          volume_mount {
            mount_path  = "/mnt/secrets-store"
            name        = local.volume.name
            read_only   = true
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