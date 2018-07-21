resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket}"
  acl    = "private"

  tags {
    Name        = "${var.bucket}"
    Environment = "${var.environment}"
  }
}

data "template_file" "s3_policy" {
  vars = {
    bucket_name = "${var.bucket}"
    arn         = "${var.nginx_policy_arn}"
  }

  template = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "NGINX_POLICY",
  "Statement": [
    {
      "Sid": "AddNginxPerm",
      "Effect": "Allow",
      "Principal": {"AWS": ["$${arn}"]},
      "Action":["s3:PutObject","s3:PutObjectAcl"],
      "Resource": "arn:aws:s3:::$${bucket_name}/*"
    } 
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "nginx_policy" {
  bucket = "${aws_s3_bucket.b.id}"

  policy = "${data.template_file.s3_policy.rendered}"
}
