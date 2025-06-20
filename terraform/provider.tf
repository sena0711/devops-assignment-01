terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95, < 6.0.0"
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


variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "ARN for the AWS role used by Terraform Cloud"
  type        = string
}

