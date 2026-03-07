variable "vpc_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "bastion_allowed_ips" {
  type        = list(string)
  description = "CIDR blocks allowed to access the Bastion host via SSH"
}
