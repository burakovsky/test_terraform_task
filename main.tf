# # Configure s3 bucket as backend for terraform
# terraform {
#   backend "s3" {}
# }

# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create the PVC
module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "${var.vpc_cidr}"
  environment = "${var.environment}"
}