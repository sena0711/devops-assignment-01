terraform {
  required_version = ">= 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
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
  region = var.aws_region
}


variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "ARN for the AWS role used by Terraform Cloud"
  type        = string
}