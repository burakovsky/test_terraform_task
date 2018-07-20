variable "name" {}

variable "environment" {}

variable "instance_port" {}

variable "instance_protocol" {}

variable "lb_port" {}

variable "lb_protocol" {}

variable "healthy_threshold" {}

variable "unhealthy_threshold" {}

variable "health_check_timeout" {}

variable "health_check_target" {}

variable "health_check_interval" {}

variable "subnet_id" {
  type = "list"
}

variable "security_group_ids" {
  type = "list"
}
