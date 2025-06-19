#######################################
# VPC
#######################################
output "vpc_id" {
  description = "ID of the VPC"
  value = module.vpc.vpc_id
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.igw_id
}
#######################################
# Subnet
#######################################
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = module.subnet.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = module.subnet.private_subnet_ids
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value = module.subnet.nat_gateway_id
}