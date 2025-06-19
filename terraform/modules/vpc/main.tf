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

#######################################
# Internet Gateway
#######################################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags
  )
}
