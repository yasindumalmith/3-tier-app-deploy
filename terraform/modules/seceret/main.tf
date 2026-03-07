resource "aws_secretsmanager_secret" "db_secret" {
  name                    = var.secret_name
  recovery_window_in_days = 0 # 0 days for easy deletion in dev/test, otherwise 7-30 days
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    endpoint = var.db_endpoint
    dbname   = var.db_name
  })
}
