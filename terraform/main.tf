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

  
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }


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

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      name          = "eks-nodegroup"

      min_size     = 1
      max_size     = 3
      desired_size = 2
      subnet_ids      = module.vpc.private_subnets

      instance_types = ["t4g.medium"]
      ami_type       = "AL2_ARM_64" 
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = local.general_tags
}

########################################
# alb_controller (custom) add lbclass
########################################
module "alb_controller" {
  source = "./module/alb-controller"
  
  oidc_provider_arn = data.aws_iam_openid_connect_provider.oidc.arn
  oidc_provider_url = replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")
  iam_role_name     = "AmazonEKSLoadBalancerControllerRole"

  depends_on = [module.eks]
}
