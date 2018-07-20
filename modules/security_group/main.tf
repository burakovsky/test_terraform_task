# Create security group
resource "aws_security_group" "security_group" {
  name   = "${var.sg_name}"
  vpc_id = "${var.vpc_id}"

  tags {
    Environment = "${var.environment}"
  }
}

#Create ingress rules for the security group
resource "aws_security_group_rule" "ingress_rules" {
  security_group_id = "${aws_security_group.security_group.id}"
  count             = "${length(var.ingress_port_range)}"
  from_port         = "${element(var.ingress_port_range, count.index)}"
  to_port           = "${element(var.ingress_port_range, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = "${var.ingress_cidr_blocks}"
  type              = "ingress"
}

#Create egress rules for the security group
resource "aws_security_group_rule" "egress_rules" {
  security_group_id = "${aws_security_group.security_group.id}"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}
