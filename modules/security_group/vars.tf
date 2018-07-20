variable "vpc_id" {}

variable "environment" {}

variable "sg_name" {}

variable "ingress_port_range" {
  type = "list"
}

variable "ingress_cidr_blocks" {
  type = "list"
}
