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

#######################################
# Elastic IP for NAT Gateway
#######################################

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.name}-nat-eip"
    },
    var.tags
  )
}

#######################################
# NAT Gateway (must be in Public Subnet)
#######################################

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  

  tags = merge(
    {
      Name = "${var.name}-nat-gw"
    },
    var.tags
  )
}

#######################################
# Private Route Table
#######################################

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.name}-private-rt"
    },
    var.tags
  )
}

#######################################
# Route to NAT Gateway
#######################################

resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

#######################################
# Associate Private Subnets with Private Route Table
#######################################

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
