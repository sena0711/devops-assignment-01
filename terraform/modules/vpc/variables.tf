# VPC 생성시 필요한 변수들

variable "tags" {
  description = "A map of tags to assign."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "name" {
  description = "Name of the VPC."
  type        = string
}


