########## General project variables ##########

variable "aws_region" {}

variable "environment" {}

variable "key_name" {}

variable "public_key" {}

########## Network variables ##########

variable "vpc_cidr" {}

variable "zones" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

########## Security groups variables ##########

variable "vpc_public_sg_name" {}

variable "vpc_public_ingress_port_range" {
  type = "list"
}

variable "vpc_private_sg_name" {}

variable "vpc_private_ingress_port_range" {
  type = "list"
}

variable "elb_sg_name" {}

variable "elb_ingress_port_range" {
  type = "list"
}
