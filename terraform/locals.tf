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
  map_accounts =  [
    "207458591579",
  ]
  map_roles = [
    {
      rolearn  = "arn:aws:iam::207458591579:role/allow-terraform-test"
      username = "terraform"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::207458591579:role/allow-full-access"
      username = "master"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::207458591579:role/eks-nodegroup-eks-node-group-2025062203433960490000000b"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:nodes", "system:bootstrappers"]
    }
  ]
  map_users = [
    {
      userarn  = "arn:aws:iam::207458591579:user/terraform-user"
      username = "master"
      groups   = ["system:masters"]
    }
  ]
  aws_auth_data = {
    mapRoles    = yamlencode(local.map_roles)
    mapUsers    = yamlencode(local.map_users)
    mapAccounts = yamlencode(local.map_accounts)
  }
}

