output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.alb_subnet_public[*].id
}

output "web_private_subnets" {
  value = aws_subnet.web_private[*].id
}

output "app_private_subnets" {
  value = aws_subnet.app_private[*].id
}

output "db_private_subnets" {
  value = aws_subnet.db_private[*].id
}
