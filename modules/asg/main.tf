resource "aws_launch_configuration" "as_conf" {
  name                        = "${var.asg_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.security_group_ids}"]
  associate_public_ip_address = "${var.associate_public_ip}"

  #user_data                   = "${file("${path.module}/userdata.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "${var.asg_name}"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier  = ["${var.subnet_ids}"]
  min_size             = "${var.min_asg_size}"
  max_size             = "${var.max_asg_size}"
  load_balancers       = ["${var.load_balancers_name}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
