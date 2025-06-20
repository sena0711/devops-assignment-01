variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-2"

}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "labs-vpc-01"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.21.0.0/16"
}
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}
variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.21.0.0/24", "10.21.1.0/24"]
}
variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.21.32.0/24", "10.21.33.0/24"]
}
variable "general_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "infra"
  }
}
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "labs-vpc"
}


