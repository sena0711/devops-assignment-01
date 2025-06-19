# Subnet 모듈에서 필요한 입력 변수들

variable "name" {
  description = "Name prefix for the subnets"
  type        = string
  default     = "labs"
}
variable "tags" {
  description = "A map of tags to assign."
  type        = map(string)
  default     = {}
}
variable "vpc_id" {
  description = "VPC ID to attach subnets"
  type        = string
}
variable "azs" {
  description = "List of availability zones"
  type = list(string)
}
variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type = list(string)
}
variable "private_subnets" {
  description = "List of private subnet CIDRs"  
  type = list(string)
}
variable "igw_id" {
  description = "Internet Gateway ID for public subnets"
  type        = string
  default     = null
}
variable "create_nat_gateway" {
  description = "Whether to create NAT Gateway"
  type        = bool
  default     = true
}