resource "aws_iam_role" "serviceaccount-role" {
  name = local.secret_role_name

  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Principal" = {
        "Federated" = local.openid
      },
      "Condition":{
        "StringEquals": {
          "${local.oidc}:sub" = "system:serviceaccount:${var.namespace}:${local.secret_policy_name}",
          "${local.oidc}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "serviceaccount-policy" {
  name        = local.secret_policy_name
  description = ""
  policy      = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Sid" = "",
      "Effect" = "Allow",
      "Action" = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource" = aws_secretsmanager_secret.rds-secret.arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "serviceaccount-policy-attachment" {
  role       = aws_iam_role.serviceaccount-role.name
  policy_arn = aws_iam_policy.serviceaccount-policy.arn
}