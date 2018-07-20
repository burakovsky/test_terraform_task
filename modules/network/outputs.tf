output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnets" {
  value = "${list(aws_subnet.pub_subnets.*.id)}"
}
