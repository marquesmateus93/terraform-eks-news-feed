resource "kubernetes_service_account_v1" "rds-secret" {
  metadata {
    name = local.service_account_name
    annotations = {
      "eks.amazonaws.com/role-arn" = var.service_account_role_arn
    }
  }
}