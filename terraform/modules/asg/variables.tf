variable "project_name" {
  type = string
}

variable "web_image_id" {
  type = string
}

variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "web_sg_id" {
  type = string
}

variable "web_user_data_base64" {
  type = string
}

variable "key_name" {
  type = string
}

variable "web_private_subnets" {
  description = "Subnet IDs for the Web ASG"
  type        = list(string)
}

variable "web_target_group_arn" {
  description = "ARN of the Web Target Group"
  type        = string
}

variable "app_image_id" {
  type = string
}

variable "app_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "app_sg_id" {
  type = string
}

variable "app_user_data_base64" {
  type = string
}

variable "app_private_subnets" {
  description = "Subnet IDs for the App ASG"
  type        = list(string)
}

variable "app_target_group_arn" {
  description = "ARN of the App Target Group"
  type        = string
}

variable "app_alb_dns_name" {
  description = "DNS name of the internal App ALB (injected into user data)"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for ASG notifications"
  type        = string
}

variable "db_endpoint" {
  description = "RDS endpoint to inject into App user data"
  type        = string
}

variable "db_username" {
  description = "Database username to inject into App user data"
  type        = string
}

variable "db_password" {
  description = "Database password to inject into App user data"
  type        = string
  sensitive   = true
}
