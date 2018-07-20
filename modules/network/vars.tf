variable "vpc_cidr" {}

variable "environment" {}

variable "subnets" {
  type = "list"
}

variable "az" {
  type = "list"
}
