variable "project_name" {}

variable "vpc_cidr" {}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "web_private_subnets" {
  type = list(string)
}

variable "app_private_subnets" {
  type = list(string)
}

variable "db_private_subnets" {
  type = list(string)
}
