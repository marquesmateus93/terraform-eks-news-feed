resource "aws_secretsmanager_secret" "rds-secret" {
  name        = local.secret_name
  description = "Application RDS MySQL secrets."

  recovery_window_in_days = 0
  #kms_key_id = "aws/secretsmanager"

  tags = merge({Name = local.secret_name},
              var.tags)
}