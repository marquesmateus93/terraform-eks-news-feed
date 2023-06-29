locals {
  secret_name         = "${var.prefix_name}-rds-secret-1"
  secret_role_name    = "${var.prefix_name}-rds-secret-role"
  secret_policy_name  = "${var.prefix_name}-rds-secret-policy"
  eks_name            = "${var.prefix_name}-eks"
  oidc                = tostring(element(split("https://", data.aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer), 1))
  openid              = "arn:aws:iam::${var.account_id}:oidc-provider/${local.oidc}"
}