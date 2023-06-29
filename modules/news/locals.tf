locals{
  deployment_name     = "${var.prefix_name}-news-deployment"
  container_name      = lower("${var.prefix_name}-news-container")
  image_name          = "${var.image.name}:${var.image.tag}"
  service_name        = lower("${var.prefix_name}-news-service")
  ingress_name        = lower("${var.prefix_name}-news-ingress")
  load_balancer_name  = lower("${var.prefix_name}-news-alb")
}