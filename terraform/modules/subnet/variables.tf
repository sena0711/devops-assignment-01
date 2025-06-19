# Subnet 모듈에서 필요한 입력 변수들

variable "vpc_id" {}
variable "azs" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}