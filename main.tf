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

#Create web ELB
module "elb_web" {
  source                = "./modules/elb"
  name                  = "${var.elb_name}"
  environment           = "${var.environment}"
  security_group_ids    = ["${list(module.sg_elb.security_group_id)}"]
  subnet_id             = ["${module.network.public_subnets}"]
  instance_port         = "${var.instance_balancing_port}"
  instance_protocol     = "${var.instance_balancing_protocol}"
  lb_port               = "${var.elb_listen_port}"
  lb_protocol           = "${var.elb_listen_protocol}"
  healthy_threshold     = "${var.elb_healthy_threshold}"
  unhealthy_threshold   = "${var.elb_unhealthy_threshold}"
  health_check_timeout  = "${var.elb_health_check_timeout}"
  health_check_target   = "${var.web_elb_health_check_target}"
  health_check_interval = "${var.elb_health_check_interval}"
}

#Create web autoscaling group
module "asg_web" {
  source              = "./modules/asg"
  asg_name            = "${var.asg_name}"
  environment         = "${var.environment}"
  image_id            = "${var.ami}"
  instance_type       = "${var.instance_type}"
  key_name            = "${module.key_pair.ec2_key_pair}"
  security_group_ids  = ["${module.sg_public_ec2.security_group_id}", "${module.sg_private_ec2.security_group_id}"]
  subnet_ids          = "${module.network.public_subnets}"
  associate_public_ip = "${var.associate_public_ip}"
  min_asg_size        = "${var.min_asg_size}"
  max_asg_size        = "${var.max_asg_size}"
  load_balancers_name = ["${module.elb_web.elb_name}"]
}
