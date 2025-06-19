#######################################
# VPC 생성
#######################################

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true     # DNS 호스트네임 활성화

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}
