output "secret_arn" {
  description = "The ARN of the database secret"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "secret_name" {
  description = "The name of the database secret"
  value       = aws_secretsmanager_secret.db_secret.name
}
