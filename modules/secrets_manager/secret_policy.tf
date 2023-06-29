resource "aws_secretsmanager_secret_policy" "rds-secret" {
  secret_arn = aws_secretsmanager_secret.rds-secret.arn
  policy     = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = "secretsmanager:GetSecretValue",
      "Principal" = {
        "AWS" = aws_iam_role.serviceaccount-role.arn
      },
      "Resource" = "*"
    }]
  })
}