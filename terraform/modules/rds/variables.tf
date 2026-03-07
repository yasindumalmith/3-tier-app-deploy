variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "db_subnets" {
  description = "List of DB subnet IDs"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security group ID for the database"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "task_manager"
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}
