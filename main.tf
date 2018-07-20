# # Configure s3 bucket as backend for terraform
# terraform {
#   backend "s3" {}
# }

# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Create the VPC, internet gateway, public subnet and route table
module "network" {
  source      = "./modules/network"
  vpc_cidr    = "${var.vpc_cidr}"
  environment = "${var.environment}"
  az          = "${var.zones}"
  subnets     = "${var.subnets}"
}

# Create key pair for ec2 instances
module "key_pair" {
  source     = "./modules/key_pair"
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

# Create security group for ec2 instances (public access)
module "sg_public_ec2" {
  source              = "./modules/security_group"
  vpc_id              = "${module.network.vpc_id}"
  environment         = "${var.environment}"
  sg_name             = "${var.vpc_public_sg_name}"
  ingress_port_range  = "${var.vpc_public_ingress_port_range}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

# Create security group for ec2 instances (private access)
module "sg_private_ec2" {
  source              = "./modules/security_group"
  vpc_id              = "${module.network.vpc_id}"
  environment         = "${var.environment}"
  sg_name             = "${var.vpc_private_sg_name}"
  ingress_port_range  = "${var.vpc_private_ingress_port_range}"
  ingress_cidr_blocks = "${list(var.vpc_cidr)}"
}

# Create security group for ELB (public access)
module "sg_elb" {
  source              = "./modules/security_group"
  vpc_id              = "${module.network.vpc_id}"
  environment         = "${var.environment}"
  sg_name             = "${var.elb_sg_name}"
  ingress_port_range  = "${var.elb_ingress_port_range}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}
