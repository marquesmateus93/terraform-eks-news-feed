output "service_account_role" {
  value = aws_iam_role.serviceaccount-role.arn
}

output "secrets_manager_id" {
  value = aws_secretsmanager_secret.rds-secret.id
}

output "secrets_manager_arn" {
  value = aws_secretsmanager_secret.rds-secret.arn
}