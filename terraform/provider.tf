terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95, < 6.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  cloud {
    organization = "terraform-assignments"

    workspaces {
      name = "devops-assignment-01"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "ARN for the AWS role used by Terraform Cloud"
  type        = string
}

