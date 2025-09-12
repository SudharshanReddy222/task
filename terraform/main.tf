terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-bucket-934746769"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source                = "./vpc-module"
  cluster_name          = var.cluster_name
  vpc_cidr              = var.vpc_cidr_block
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "eks" {
  source         = "./eks-module"
  cluster_name   = var.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = concat(
    module.vpc.public_subnet_ids,
    module.vpc.private_subnet_ids
  )
  node_groups   = var.node_groups
   environment = var.environment
}