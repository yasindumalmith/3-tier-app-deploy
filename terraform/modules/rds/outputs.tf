output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.db.endpoint
}

output "db_name" {
  description = "The database name"
  value       = aws_db_instance.db.db_name
}
