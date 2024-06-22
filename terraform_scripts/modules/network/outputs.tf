output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  description = "list of public subnet ids"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "list of private subnet ids"
  value       = aws_subnet.private_subnets[*].id
}

output "lambda_sg_id" {
  description = "security group id"
  value       = aws_security_group.lambda_sg.id
}

output "rds_sg_id" {
  description = "security group id"
  value       = aws_security_group.rds_sg.id
}

output "lambda_sg_name" {
  description = "security group name"
  value       = aws_security_group.lambda_sg.name
}

output "rds_sg_name" {
  description = "security group name"
  value       = aws_security_group.rds_sg.name
}