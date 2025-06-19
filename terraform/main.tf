# VPC 모듈 호출
module "vpc" {
  source    = "./modules/vpc"

  vpc_cidr  = var.vpc_cidr
  name      = var.vpc_name
  tags      = var.vpc_tags
}
