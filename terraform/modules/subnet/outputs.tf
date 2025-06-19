output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for s in aws_subnet.private : s.id]
}
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for s in aws_subnet.public : s.id]
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = var.create_nat_gateway ? aws_nat_gateway.this[0].id : null
}

output "private_route_table_id" {
  description = "Private Route Table ID"
  value = aws_route_table.private.id
}

output "public_route_table_id" {
  description = "Public Route Table ID"
  value = aws_route_table.public.id
}