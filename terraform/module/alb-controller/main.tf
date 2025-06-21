resource "aws_iam_role" "this" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = var.oidc_provider_arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${var.oidc_provider_url}:sub" = "system:serviceaccount:kube-system:${var.service_account_name}"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = var.alb_policy_arn
  role       = aws_iam_role.this.name
}

resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.service_account_name
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
}
