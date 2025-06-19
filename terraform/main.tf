# VPC 모듈 호출
module "vpc" {
  source    = "./modules/vpc"

  vpc_cidr  = var.vpc_cidr
  name      = var.vpc_name
  tags      = var.general_tags
}

module "subnet" {
  source             = "./modules/subnet"
  
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.vpc.igw_id
  name               = "labs"
  tags               = var.general_tags
  azs                = var.azs
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  create_nat_gateway = true
}