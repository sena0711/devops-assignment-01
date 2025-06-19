#######################################
# Public Subnet 생성 (AZ별 반복)
#######################################

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "${var.name}-public-subnet-${var.azs[count.index]}-${count.index + 1}"
    },
    var.tags
  )
}

#######################################
# Private Subnet 생성 (AZ별 반복)
#######################################

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      Name = "${var.name}-private-subnet-${var.azs[count.index]}-${count.index + 1}"
    },
    var.tags
  )
}

