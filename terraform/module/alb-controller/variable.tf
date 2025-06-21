variable "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider URL (without https://)"
  type        = string
}

variable "service_account_name" {
  default = "aws-load-balancer-controller"
}

variable "iam_role_name" {
  description = "IAM role name for ALB Controller"
  type        = string
  default = "AmazonEKSLoadBalancerControllerRole"
}
