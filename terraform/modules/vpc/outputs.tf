# 생성된 VPC ID를 상위 모듈로 반환

output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}
