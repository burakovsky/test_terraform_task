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

########## Load balancer variables ##########

variable "elb_name" {}

variable "instance_balancing_port" {
  default = 80
}

variable "instance_balancing_protocol" {
  default = "http"
}

variable "elb_listen_port" {
  default = 80
}

variable "elb_listen_protocol" {
  default = "http"
}

variable "elb_healthy_threshold" {
  default = 2
}

variable "elb_unhealthy_threshold" {
  default = 2
}

variable "elb_health_check_timeout" {
  default = 3
}

variable "elb_health_check_interval" {
  default = 30
}

variable "web_elb_health_check_target" {
  default = "HTTP:80/"
}
