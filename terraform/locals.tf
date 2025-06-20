locals {
  aws_region  = "ap-northeast-2"
  vpc_name = "labs-vpc-01"
  vpc_cidr          = "10.21.0.0/16"
  azs               = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets = ["10.21.0.0/24", "10.21.1.0/24"]
  private_subnets = ["10.21.32.0/24", "10.21.33.0/24"]
  general_tags = {
    Environment = "dev"
    Owner       = "infra"
  }
  cluster_name = "labs-eks-cluster"

}


