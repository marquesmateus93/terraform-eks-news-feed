resource "kubernetes_manifest" "rds-secret" {
  manifest = {
    apiVersion  = var.kubernetes_manifest.apiVersion
    kind        = var.kubernetes_manifest.kind
    metadata = {
      name = local.secret_provider_class_name
      namespace = var.kubernetes_manifest.namespace
    }
    spec = {
      provider = var.kubernetes_manifest.provider
      parameters = {
        objects = yamlencode({
          objectName = var.secrets_manager_arn,
          jmesPath = [{
            path        = "name"
            objectAlias = "db_name"
          },{
            path        = "username"
            objectAlias = "user_name"
          },{
            path        = "password"
            objectAlias = "user_password"
          }]
        })
      }
    }
  }
}

# yamlencode({objectName = "ARN", jmesPath = [{path = "pathName", objectAlias = "aliasName"}]})