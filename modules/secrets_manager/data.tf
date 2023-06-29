data "aws_eks_cluster" "eks-cluster" {
  name = local.eks_name
}

data "aws_secretsmanager_random_password" "rds-secret" {
  password_length     = 32
  exclude_lowercase   = false
  exclude_numbers     = false
  exclude_punctuation = true
}