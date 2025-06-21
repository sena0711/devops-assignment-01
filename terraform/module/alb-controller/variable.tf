variable "oidc_provider_arn" {}
variable "oidc_provider_url" {}
variable "service_account_name" {
  default = "aws-load-balancer-controller"
}
variable "iam_role_name" {
  default = "AmazonEKSLoadBalancerControllerRole"
}
