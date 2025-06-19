# AWS 리전 설정
variable "aws_region" {
  default = "ap-northeast-2"  # 서울 리전 사용
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

variable "vpc_tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "infra"
  }
}
