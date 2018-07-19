# Specify the provider and access details
provider "aws" {
  region = "${var.region}"
}

#Create s3 backet for terraform.tfstate files
resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.bucket}"
    Environment = "${var.environment}"
  }
}
