variable "asg_name" {}

variable "environment" {}

variable "image_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "associate_public_ip" {}

variable "min_asg_size" {}

variable "max_asg_size" {}

variable "bucket_name" {}

variable "security_group_ids" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "load_balancers_name" {
  type = "list"
}
