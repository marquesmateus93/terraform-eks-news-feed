resource "aws_secretsmanager_secret_version" "rds-secret" {
  secret_id = aws_secretsmanager_secret.rds-secret.id
  secret_string = jsonencode(
    {
      name:     "db_company"
      username: "company_user"
      password: data.aws_secretsmanager_random_password.rds-secret.random_password
    }
  )
}