# AWS 리전 설정
variable "aws_region" {
  default = "ap-northeast-2" # 서울 리전 사용
}
# VPC
variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  default     = "labs-vpc-01"
  description = "Name of the VPC"
}

variable "general_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "infra"
  }
}
variable "subnet_name" {
  description = "Name prefix for the resources"
  type        = string
  default     = "labs"
}
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnets" {
  description = "Public Subnet CIDR blocks"
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnets" {
  description = "Private Subnet CIDR blocks"
  default     = ["10.20.101.0/24", "10.20.102.0/24"]
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "spoonlabs-eks-cluster"
}


