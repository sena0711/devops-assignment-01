# VPC 모듈 호출
module "vpc" {
  source    = "./modules/vpc"

  vpc_cidr  = var.vpc_cidr
  name      = var.vpc_name
  tags      = var.general_tags
}


module "subnet" {
  source = "./modules/subnet"

  vpc_id          = module.vpc.vpc_id
  azs             = var.azs
  igw_id          = module.vpc.igw_id  # ⬅ IGW 연결
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  name            = var.subnet_name
  tags            = var.general_tags
}
