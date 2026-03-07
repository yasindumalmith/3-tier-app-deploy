variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "web_private_subnets" {
  description = "Web Private subnet CIDR blocks"
  type        = list(string)
}

variable "app_private_subnets" {
  description = "App Private subnet CIDR blocks"
  type        = list(string)
}

variable "db_private_subnets" {
  description = "Database Private subnet CIDR blocks"
  type        = list(string)
}


variable "bastion_ami" {
  description = "AMI ID for the Bastion Host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the Bastion Host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair to access the Bastion Host"
  type        = string
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

variable "web_image_id" {
  description = "AMI ID for the Web Server"
  type        = string
}

variable "web_instance_type" {
  description = "Instance type for the Web Server"
  type        = string
  default     = "t2.micro"
}

#variable "web_sg_id" {
#  description = "Security group ID for the Web Server"
#  type        = string
#}

variable "web_user_data_base64" {
  description = "User data for the Web Server"
  type        = string
}

variable "app_image_id" {
  description = "AMI ID for the App Server"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for the App Server"
  type        = string
  default     = "t2.micro"
}

#variable "app_sg_id" {
#  description = "Security group ID for the App Server"
#  type        = string
#}

variable "app_user_data_base64" {
  description = "User data for the App Server"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for notifications"
  type        = string
}



