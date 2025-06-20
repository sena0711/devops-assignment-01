output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

# output "eks_cluster_id" {
#   value = module.eks.cluster_id
# }
# 
# output "eks_cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }
# 
# 
# output "eks_cluster_name" {
#   value       = module.eks.cluster_name
# }
# 
# output "eks_cluster_security_group_id" {
#   value       = module.eks.cluster_primary_security_group_id
# }
# 
