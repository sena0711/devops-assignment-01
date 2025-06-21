########################################
# VPC Module (official)
########################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.general_tags
}


########################################
# EKS Module (official)
########################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1" # Use the latest stable version

  cluster_name    = local.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t4g.medium"]
      ami_type       = "AL2_ARM_64" 
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = local.general_tags
}

module "aws_auth" {
  source = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.8.4"

  manage_aws_auth_configmap = true

  
  # 클러스터가 생성된 이후 실행되도록 의존성 추가
  depends_on = [module.eks]

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::207458591579:role/allow-full-access"
      username = "allow-full-access"
      groups   = ["system:masters"]
    },
  ]
}