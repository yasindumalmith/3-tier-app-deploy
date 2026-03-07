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
