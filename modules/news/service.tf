resource "kubernetes_service_v1" "service" {
  metadata {
    #name = local.service_name
    name = "dev-marques-ops-news-service"
  }
  spec {
    selector = {
      app = var.prefix_name
    }
    type = "NodePort"
    session_affinity = "ClientIP"
    port {
      name        = "http"
      port        = 8081
      target_port = "80"
    }
  }
}