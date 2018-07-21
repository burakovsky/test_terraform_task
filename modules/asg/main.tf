resource "aws_iam_role" "s3_access" {
  name = "s3_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "template_file" "policy_text" {
  vars = {
    bucket_name = "${var.bucket_name}"
  }

  template = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:ListBucket"],
            "Resource": ["arn:aws:s3:::$${bucket_name}"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": ["arn:aws:s3:::$${bucket_name}/*"]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "s3_access" {
  name = "s3_access"
  role = "${aws_iam_role.s3_access.id}"

  policy = "${template_file.policy_text.rendered}"
}

resource "aws_iam_instance_profile" "s3_access" {
  name = "s3_access_burakouski"
  role = "${aws_iam_role.s3_access.name}"
}

resource "aws_launch_configuration" "as_conf" {
  name                        = "${var.asg_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.security_group_ids}"]
  iam_instance_profile        = "${aws_iam_instance_profile.s3_access.name}"
  associate_public_ip_address = "${var.associate_public_ip}"

  user_data = "${file("${path.module}/userdata.sh")}"

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
