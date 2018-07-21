output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "s3_access_role_arn" {
  value = "${aws_iam_role.s3_access.arn}"
}
