# Terraform Cloud backend 설정
terraform {
  cloud {
    organization = "terraform-assignments"

    workspaces {
      name = "devops-assignment-01"
    }
  }

  required_version = ">= 1.1.2"
}


variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "ARN for the AWS role used by Terraform Cloud"
  type        = string
}