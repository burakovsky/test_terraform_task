# Create ELB
resource "aws_elb" "elb" {
  name            = "${var.name}"
  security_groups = ["${var.security_group_ids}"]
  subnets         = ["${var.subnet_id}"]

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.instance_protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.lb_protocol}"
  }

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.health_check_timeout}"
    target              = "${var.health_check_target}"
    interval            = "${var.health_check_interval}"
  }

  tags {
    Environment = "${var.environment}"
  }
}
