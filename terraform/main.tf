terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  azs                 = var.azs
  public_subnets      = var.public_subnets
  web_private_subnets = var.web_private_subnets
  app_private_subnets = var.app_private_subnets
  db_private_subnets  = var.db_private_subnets
}

module "sg" {
  source = "./modules/sg"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "bastion" {
  source = "./modules/bastion-host"

  image_id        = var.bastion_ami
  instance_type   = var.bastion_instance_type
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [module.sg.bastion_sg_id]
  key_name        = var.key_name

  tags = {
    Name = "bastion-${var.project_name}"
  }
}

module "alb" {
  source = "./modules/alb"

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg_id      = module.sg.frontend_alb_sg_id
  app_subnets    = module.vpc.app_private_subnets
  app_sg_id      = module.sg.app_alb_internal_sg_id
}

module "rds" {
  source = "./modules/rds"

  project_name      = var.project_name
  db_subnets        = module.vpc.db_private_subnets
  db_sg_id          = module.sg.db_sg_id
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
}

module "secret" {
  source = "./modules/seceret"

  secret_name = "${var.project_name}-db-secret-${random_string.suffix.result}"
  db_username = var.db_username
  db_password = var.db_password
  db_endpoint = module.rds.db_endpoint
  db_name     = module.rds.db_name
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
