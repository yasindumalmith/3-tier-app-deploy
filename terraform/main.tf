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
