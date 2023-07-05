locals{
  deployment_name             = "${var.prefix_name}-system-deployment"
  container_name              = lower("${var.prefix_name}-system-container")
  image_name                  = "${var.image.name}:${var.image.tag}"
  service_name                = lower("${var.prefix_name}-system-service")
  ingress_name                = lower("${var.prefix_name}-system-ingress")
  load_balancer_name          = lower("${var.prefix_name}-system-alb")
  service_account_name        = lower("${var.prefix_name}-service-account")
  secret_provider_class_name  = lower("${var.prefix_name}-secret-provider-class")
  volume                 = {
    name                  = lower("${var.prefix_name}-volume")
    driver                = "secrets-store.csi.k8s.io"
    secret_provider_class = local.secret_provider_class_name
    volume_mount_name     = lower("${var.prefix_name}-volume-mount")
  }
}