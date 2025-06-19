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

#######################################
# Public Route Table
#######################################

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.name}-public-rt"
    },
    var.tags
  )
}

#######################################
# Route to Internet Gateway
#######################################

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

#######################################
# Associate Public Subnets with Route Table
#######################################

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
